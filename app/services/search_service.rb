# Module that decodes the passed list of words,
# and enqueues them for scraping
module SearchService
  def SearchService.parse(data, user_id)
    raw_data = data.gsub('data:text/csv;base64,', '')
    decoded_data = Base64.strict_decode64(raw_data)
    parsed_data = decoded_data.gsub("\n", ',').split(',')

    parsed_data.each do |keyword|
      ScrapeWorker.perform_async(keyword, user_id)
    end
  end
end
