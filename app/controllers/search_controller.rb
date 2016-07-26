class SearchController < ApplicationController
  include Authorization::SearchAuthorization

  def index
  end

  def create
    SearchService.parse(params[:data], current_user.id)
    head :ok
  end
end
