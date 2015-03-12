class PostsController < ApplicationController
  def new
  end

  def create
    poster = Poster.new(params[:post])
    poster.publish_to_all
  end

  def twitter_params
    params.require(:tweet).permit(:status)
  end
end