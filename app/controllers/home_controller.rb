class HomeController < ApplicationController
  def show
    @user = logged_in? ? current_user : nil
  end
end
