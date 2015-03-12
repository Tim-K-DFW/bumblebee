class SessionsController < ApplicationController
  def add
    @identity = Identity.from_omniauth(env['omniauth.auth'])
    session[params["provider"].to_sym] = @identity.uid
    redirect_to root_path
  end

  def destroy
    session[params["provider"]] = nil
    redirect_to root_path
  end
end