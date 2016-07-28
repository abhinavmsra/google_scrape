# Module that executes the custom queries
module LinksQueryService
  def LinksQueryService.query(params)
    to_json Link.contains(params[:contains]).matches_url(params[:url]).having_path_depth(params[:path_depth].to_i)
  end

  def LinksQueryService.to_json(links)
    links.map do |link|
      link.as_json.merge({keyword: link.search_result.key_word})
    end
  end
end
