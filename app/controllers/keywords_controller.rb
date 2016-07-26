class KeywordsController < ApplicationController
  include Authorization::SearchAuthorization

  def index
    @keywords = SearchResult.paginate(page: params[:page], per_page: 10)
  end

  def show
    @keyword = SearchResult.find(params[:id])
  end
end
