class ApplicationController < ActionController::Base
  #load_and_authorize_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

protected

    def configure_permitted_parameters
        # Fields for sign up
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :name, :surname, :address, :pesel, :doctor, :pwz) }
        # Fields for editing an existing account
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :name, :surname, :address, :pesel) }
    end


end
