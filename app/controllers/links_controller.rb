class LinksController < ApplicationController
  def index
    render json: { links: LinksQueryService.query(params) }
  end

  def query

  end
end
