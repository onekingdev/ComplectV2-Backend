class Api::BaseController < ApplicationController
  include ::Pundit
  before_action :authenticate_user!
  before_action :disable_employee
  respond_to :json

  def authorize_action(policy = nil)
    authorize request.headers['HTTP_BUSINESS_ID'].to_i, policy_class: policy if policy
  end

  private

  def disable_employee
    return render json: { error: I18n.t("employees.errors.disabled") } if current_user.employee && !current_user.employee.active?
  end
end
