class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    invited_employee = false
    if params[:invite_hash].present?
      invited_employee = Employee.find_by_invite_hash(params[:invite_hash])
      return render json: { error: I18n.t("employees.errors.not_found") } if invited_employee.nil?
      return render json: { error: I18n.t("employees.errors.user_assigned") } if invited_employee.user_id.present?
      return render json: { error: I18n.t("employees.errors.disabled") } unless invited_employee.active?
    end
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.kind == "employee"
        if invited_employee
          invited_employee.update(user_id: resource.id)
        else
          resource.build_business.save
          resource.build_employee(first_name: resource.profile.first_name,
                                  last_name: resource.profile.last_name,
                                  invite_email: resource.email,
                                  start_date: Time.zone.now,
                                  role: "admin",
                                  user_id: resource.id,
                                  active: true,
                                  business_id: resource.business.id).save
        end
      end
      resource.update!(otp_secret: User.generate_otp_secret)
      resource.send_otp
      set_flash_message! :notice, :signed_up
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: I18n.t("users.actions.register_success") }
  end

  def register_failed
    render json: { message: I18n.t("users.actions.register_failed") }
  end
end
