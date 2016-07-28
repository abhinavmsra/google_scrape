class LinksController < ApplicationController

  # Performs the custom Query for the URLs
  #
  # @method GET
  # Permitted Request Params:
  #   1) contains - URL contains the string
  #   2) url - URL having a specific link
  #   3) path_depth - Links having specific path depth
  #
  # @return Hash, json representation of the Link object
  def index
    render json: { links: LinksQueryService.query(params) }
  end

  def query
  end
end
