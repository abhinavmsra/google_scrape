class KeywordsController < ApplicationController
  include Authorization::UserAuthorization

  def index
    @keywords = SearchResult.paginate(page: params[:page], per_page: 20)
  end

  def show
    @keyword = SearchResult.find(params[:id])
  end
end
