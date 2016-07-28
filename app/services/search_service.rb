module SearchService
  def SearchService.parse(data, user_id)
    raw_data = data.gsub('data:text/csv;base64,', '')
    decoded_data = Base64.strict_decode64(raw_data).gsub("\n", ',')
    parsed_data = decoded_data.gsub("\n", '').split(',')

    parsed_data.each do |keyword|
      ScrapeWorker.perform_async(keyword, user_id)
    end
  end
end
