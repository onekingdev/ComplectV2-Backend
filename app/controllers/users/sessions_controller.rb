class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # include Devise::Controllers::Rails7ApiMode

  def create
    user = User.find_first_by_auth_conditions(email: params[:user][:email])
    return render json: { error: I18n.t("users.errors.wrong_password") } unless user.valid_password?(params[:user][:password])
    return render json: { error: I18n.t("employees.errors.disabled") } if user.employee && !user.employee.active?

    user.update!(otp_secret: User.generate_otp_secret) if user.otp_secret.nil?
    if params[:user][:otp_attempt].blank?
      user.send_otp
      return render json: { error: I18n.t("users.errors.missing_otp") }
    end
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def respond_with(resource, _opts = {})
    render json: { auth_token: Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first }, status: :ok
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: I18n.t("users.actions.signed_out") }, status: :ok
  end

  def log_out_failure
    render json: { message: I18n.t("users.errors.sign_out") }, status: :unauthorized
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end
end
