class ApplicationController < ActionController::API
  include ::Pundit
  before_action :configure_sanitized_params, if: :devise_controller?

  def authorize_action(policy = nil)
    authorize request.headers['HTTP_BUSINESS_ID'].to_i, policy_class: policy if policy
  end

  def configure_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kind, { profile_attributes: [:first_name, :last_name] }])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end
end
