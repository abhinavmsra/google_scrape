require 'httparty'
require 'nokogiri'

class ScrapeWorker
  include Sidekiq::Worker

  GOOGLE_BASE_URL = 'https://www.google.com/search?q='
  PUBLIC_IP_FETCH_API = 'https://api.ipify.org?format=json'
  TOP_AD_CSS_CLASS = '._Ak#_Ltg'
  BOTTOM_AD_CSS_CLASS = '._Ak#_Ktg'
  ADS_CSS_IDENTIFIER = 'li.ads-ad'
  AD_URL_IDENTIFIER = 'cite'
  NON_AD_CSS_IDENTIFIER = '.g'
  NON_AD_URL_IDENTIFIER = '.r a'
  TOTAL_RESULTS_CSS_IDENTIFIER = '#resultStats'

  def perform(keyword, user_id)
    query_key_word = keyword.gsub(/\s/, '+')

    response = HTTParty.get("#{GOOGLE_BASE_URL}#{query_key_word}")
    parse_page = Nokogiri::HTML(response)

    ip = HTTParty.get(PUBLIC_IP_FETCH_API)['ip']

    links_attributes = []

    parse_page.css(TOP_AD_CSS_CLASS).children.css(ADS_CSS_IDENTIFIER).each do |ad|
      links_attributes << {link_type: Link.link_types[:top_ad], url: ad.css(AD_URL_IDENTIFIER).text}
    end

    parse_page.css(BOTTOM_AD_CSS_CLASS).children.css(ADS_CSS_IDENTIFIER).each do |ad|
      links_attributes << { link_type: Link.link_types[:bottom_ad], url: ad.css(AD_URL_IDENTIFIER).text }
    end

    parse_page.css(NON_AD_CSS_IDENTIFIER).each do |result|
      result_headline = result.children.css('h3')
      unless result_headline.empty?
        url = result_headline.css(NON_AD_URL_IDENTIFIER).attr('href').value
        parsed_url = URI.extract(url).first
        links_attributes << { link_type: Link.link_types[:non_ad],
                              url: parsed_url.gsub(/&.*/, '') } if parsed_url
      end
    end

    total_search_count = parse_page.at_css(TOTAL_RESULTS_CSS_IDENTIFIER).text.gsub(/\D/, '')
    total_links_count = parse_page.css('a').count
    binding.pry
    p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
    pp data = {
      key_word: keyword,
      user_id: user_id,
      search_count: total_search_count,
      links_count: total_links_count,
      worker_ip: ip,
      links_attributes: links_attributes
    }

    SearchResult.create!({
      key_word: keyword, user_id: user_id,
      search_count: total_search_count,
      links_count: total_links_count,
      html_code: response.body.encode('UTF-8'),
      worker_ip: ip,
      links_attributes: links_attributes
    })
  end
end
