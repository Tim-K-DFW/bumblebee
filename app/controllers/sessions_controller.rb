class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env['omniauth.auth'])
    @user.get_profile_data_from_provider
    session[:user_id] = @user.id
    session[:screen_name] = @user.screen_name
    session[:image_url] = @user.image_url
    session[:url] = @user.url
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
