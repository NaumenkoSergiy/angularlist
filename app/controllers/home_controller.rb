class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path unless signed_in?
  end
end
