class SearchController < ApplicationController
  include Authorization::UserAuthorization

  def index
  end

  # Performs the scraping task of the keywords
  #
  # @params Hash, Base64 encoded csv file of strings
  #  Structure:
  #     {
  #       data: 'VGhlIHByZXNpZGVudOKAmXMgY29udGVtcHQgZm9yIE1yLiBUcnVtcCB0b29rIG9uIGEgcGVyc29
  #               uYWwgZGltZW5zaW9uIGFzIHdlbGwgd2hlbiBoZSByZWNhbGxlZCBoaXMgZ3JhbmRwYXJlbnRzIGZ
  #               yb20gS2Fuc2FzIGFuZCBzYWlkLCDigJxJIGRvbuKAmXQga25vdyBpZiB0aGV5IGhhZCB0aGVpc
  #               iBiaXJ0aCBjZXJ0aWZpY2F0ZXPigJ0g4oCUIGEgcmVmZXJlbmNlIHRvIE1yLiBUcnVtcOKAmXM'
  # }
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
