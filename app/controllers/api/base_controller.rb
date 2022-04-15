class Api::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :disable_employee
  respond_to :json

  private

  def disable_employee
    return render json: { error: "Account is disabled" } if current_user.employee && !current_user.employee.active?
  end
end
