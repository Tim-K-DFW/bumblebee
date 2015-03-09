class HomeController < ApplicationController
  def show
    @user = logged_in? ? current_user : nil
    @user.get_profile_data_from_provider if logged_in?
  end
end
