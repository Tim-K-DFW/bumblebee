module ApplicationHelper
  def pretty_provider_name(provider)
    provider == :linkedin ? 'LinkedIn' : provider.to_s.humanize
  end
end
