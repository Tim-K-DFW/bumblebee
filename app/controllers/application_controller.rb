#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_identity, :logged_in?

  def logged_in?(provider)
    !session[provider].nil?
  end

  def current_identity(provider)
    return unless logged_in?(provider)
    Identity.where(provider: provider, uid: session[provider]).first
  end
end
