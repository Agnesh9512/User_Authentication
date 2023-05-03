class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :prepare_exception_notifier

  include Pundit::Authorization
  # Added after adding name column in devise, this is mandatory to add below method
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  # device_parameter_sanitizer is a helper. Override this method to use your own parameter sanitizer.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :password_confirmation) }
  end

  # Used for using exception notifier gem, to sending notifications when errors occur
  def prepare_exception_notifier
    request.env['exception_notifier.exception_data'] = {
      current_user: @user
    }
  end

end


