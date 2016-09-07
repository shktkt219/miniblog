class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include UsersHelper

  #ParameterSanitizer deals with permitting specific parameters values for each Devise scope in app.
  #the sanitizer know about Devise default params and this cord can extend the permitted params.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_url
  end
end
