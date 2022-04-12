class Api::EmployeesController < Api::BaseController
  before_action :get_business

  def index
    render json: @business.employees, each_serializer: EmployeeSerializer
  end

  def create
    employee = @business.employees.build(employee_params.merge(invite_hash: SecureRandom.uuid))
    puts "BUILD EMPLOYEE WITH INVITE HASH"
    puts employee.inspect
    if employee.save
      puts "**** Invite hash: ****\n#{employee.invite_hash}\n**********************" if Rails.env == "development"
      EmployeeMailer.send_invite(employee.invite_email, employee.invite_hash) if Rails.env != "development"
      render json: employee, serializer: EmployeeSerializer
    else
      render json: { errors: employee.errors }, status: :unprocessable_entity
    end
  end

  def update
    employee = @business.employees.find(params[:id])
    if employee.update(employee_params)
      render json: employee, serializer: EmployeeSerializer
    else
      render json: { errors: employee.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    employee = @business.employees.find(params[:id])
    return render json: { error: "Employee has already assigned User" } if employee.user.present?

    if employee.destroy
      render json: { message: 'Removed employee' }
    else
      render json: { errors: employee.errors }, status: :unprocessable_entity
    end
  end

  private

  def get_business
    @business = current_user.business
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :invite_email, :disabled_reason, :additional_reason,
                                     :access_person, :role, :active)
  end
end
