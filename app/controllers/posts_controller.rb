class PostsController < ApplicationController
  def new
  end

  def create
    @poster = Poster.new(params[:post], logins_from_session)
    @poster.batch_publish
    render '/posts/create', locals: {status: @poster.status}
  end

  private

  def logins_from_session
    result = {}
    Poster::POST_METHODS.keys.each do |provider|
      result[provider] = session[provider] if session[provider]
    end
    result
  end

end