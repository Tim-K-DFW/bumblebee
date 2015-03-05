class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.tweet(twitter_params[:status])
  end

  def twitter_params
    params.require(:tweet).permit(:status)
  end
end