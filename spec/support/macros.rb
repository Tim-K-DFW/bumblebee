PROVIDERS = %w(facebook twitter salesforce linkedin)

# def set_up_session(provider)
#   @identity = Identity.from_omniauth(env['omniauth.auth'])
#   session[provider] = @identity.uid
#   redirect_to root_path
# end

# def end_session(provider)
#   session[params["provider"]] = nil
#   redirect_to root_path
# end

# def logged_in?(provider)
#   binding.pry
#   !!session[provider]
# end

# def current_identity(provider)
#   logged_in?(provider) ? Identity.where(provider: provider, uid: session[provider]).first : nil
# end

def logged_in?(provider)
  binding.pry
  page.has_content?("logged into #{provider.to_s.humanize}")
end