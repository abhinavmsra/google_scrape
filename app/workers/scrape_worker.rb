require 'httparty'
require 'nokogiri'

class ScrapeWorker
  include Sidekiq::Worker

  def perform(keyword, user_id)
    query_key_word = keyword.gsub(/\s/, '+')

    response = HTTParty.get("https://www.google.com/search?q=#{query_key_word}")
    parse_page = Nokogiri::HTML(response)

    links_attributes = []

    parse_page.css('._Ak#_Ltg').children.css('li.ads-ad').each do |ad|
      links_attributes << {link_type: Link.link_types[:top_ad], url: ad.css('cite').text}
    end

    parse_page.css('._Ak#_Ktg').children.css('li.ads-ad').each do |ad|
      links_attributes << { link_type: Link.link_types[:bottom_ad], url: ad.css('cite').text }
    end

    parse_page.css('.g').each do |result|
      result_headline = result.children.css('h3')
      unless result_headline.empty?
        url = result_headline.css('.r a').attr('href').value
        parsed_url = URI.extract(url).first
        links_attributes << { link_type: Link.link_types[:result],
                              url: parsed_url.gsub(/&.*/, '') } if parsed_url
      end
    end

    total_search_count = parse_page.at_css('#resultStats').text.gsub(/\D/, '')

    SearchResult.create!({
      key_word: keyword, user_id: user_id, search_count: total_search_count,
      links_count: 23, html_code: response.body,
    links_attributes: links_attributes
    })
  end
end
