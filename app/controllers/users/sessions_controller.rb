class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # include Devise::Controllers::Rails7ApiMode

  def new
    render json: { message: "Please sign in." }
  end

  def create
    user = User.find_first_by_auth_conditions(email: params[:user][:email])
    return render json: { error: "Wrong password" } unless user.valid_password?(params[:user][:password])

    user.update!(otp_secret: User.generate_otp_secret) if user.otp_secret.nil?
    if params[:user][:otp_attempt].blank?
      user.send_otp
      return render json: { error: "Missing OTP" }
    end
    self.resource = warden.authenticate!(auth_options)
    # set_flash_message!(:notice, :signed_in)
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
    render json: { message: "Signed out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Sign out failure." }, status: :unauthorized
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end
end
