class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include UsersHelper

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please Sign in."
      redirect_to new_user_session_path
    end
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_url
  end
end
