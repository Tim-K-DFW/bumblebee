class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if logged_in?
      @current_user ||= User.find(session[:user_id])
      @current_user.screen_name = session[:screen_name]
      @current_user.image_url = session[:image_url]
      @current_user.url = session[:url]
      @current_user
    else
      nil
    end
  end
end
