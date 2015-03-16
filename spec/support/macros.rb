PROVIDERS = %w(facebook twitter salesforce linkedin)

def logged_in?(provider)
  page.has_content?("Logged into #{provider == :linkedin ? 'LinkedIn' : provider.to_s.humanize}")
end

def seed_session_with_logins
  session[:facebook] = "999"
  session[:twitter] = "999"
  session[:linkedin] = "999"
  session[:salesforce] = "999"
end