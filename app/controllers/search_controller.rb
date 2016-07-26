class SearchController < ApplicationController
  include Authorization::SearchAuthorization

  def index
  end

  def create
    begin
      SearchService.parse(params[:data], current_user.id)
      response, status  = 'success', :ok
    rescue ArgumentError
      response, status = 'error', :bad_request
    end
    render json: {status: response}, status: status
  end
end
