class ApplicationController < ActionController::Base
	before_filter :configure_parameters, :if => :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
  
  def configure_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :email, :password, :password_confirmation, :first_name, :last_name
    end
  end
end
