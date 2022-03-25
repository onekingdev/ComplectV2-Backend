class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # include Devise::Controllers::Rails7ApiMode

  def new
    render json: { message: "Please sign in." }
  end

  private
  def respond_with(resource, _opts = {})
    render json: { message: 'Signed in.' }, status: :ok
  end
  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end
  def log_out_success
    render json: { message: "Signed out." }, status: :ok
  end
  def log_out_failure
    render json: { message: "Sign out failure."}, status: :unauthorized
  end
end