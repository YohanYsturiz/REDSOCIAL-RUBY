class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :set_layout
  before_action :configuar_strong_params, if: :devise_controller?
  
  protected
    def set_layout
      "application"
    end
    
    def configuar_strong_params
      devise_parameter_sanitizer.permit(:sign_up,keys: [:username])
    end
end
