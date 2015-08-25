require 'top_tal_api'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
  end

  def after_sign_out_path_for(resource_or_scope)
    user_session_path
  end

  def signed_in?
    !!current_user
  end

  helper_method :signed_up?

  def authenticate_user!
    render json: {error: 'access denied'} and return if !current_user
  end

  def current_user
    @current_user ||= TopTalApi.find_user_by(params[:token] || session[:token])
  end
end
