class ApplicationController < ActionController::API
  before_action :configure_sanitized_params, if: :devise_controller?

  def configure_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kind, { profile_attributes: [:first_name, :last_name] }])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end
end
