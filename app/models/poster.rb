class Poster
  attr_accessor :body, :providers, :author

  def initialize(args)
    @body = args[:body]
    @providers = get_providers(args)
  end

  def publish_to_all
    providers.each do |provider|
      if session[provider]
        author = Identity.where(provider: provider, uid: session[provider])
      else

      end
    end
  end

  private

  def get_providers(args)
    result = []
    result << 'twitter'.to_sym if args[:to_twitter] == '1'
    result << 'facebook'.to_sym if args[:to_facebook] == '1'
    result
  end


  #were moved from Identity model, need that argument

  def post_to_fb(post)
    client = set_up_facebook_client
    client.put_connections("me", "feed", :message => post)
  end

  def tweet(tweet)
    client = set_up_twitter_client
    client.update(tweet)
  end

end