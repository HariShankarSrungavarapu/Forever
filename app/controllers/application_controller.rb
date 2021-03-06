class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_timezone
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  def set_timezone
    Time.zone = 'Kolkata'
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:name, :gender, :avatar, :status, :dob, :occupation, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end


end

