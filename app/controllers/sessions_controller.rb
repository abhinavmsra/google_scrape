class SessionsController < ApplicationController
  include Authorization::SessionsAuthorization

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to search_index_path
    rescue
      flash[:warning] = 'There was an error while trying to authenticate you...'
      redirect root_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'See you!'
    redirect_to root_path
  end
end
