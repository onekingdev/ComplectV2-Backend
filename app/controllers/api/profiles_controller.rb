class Api::ProfilesController < Api::BaseController
  before_action :get_profile

  def update
    if @profile.update(profile_params)
      render json: @profile, serializer: ProfileSerializer
    else
      render json: { errors: @profile.errors, status: :unprocessable_entity }
    end
  end

  def show
    respond_with @profile, serializer: ProfileSerializer
  end

  private

  def get_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :time_zone, :address, :apt_unit, :city, :state,
                                    :phone_number, :zipcode, :availability, :former_regulator, :hourly_rate,
                                    :avatar, :file, :experience, :show_full_name)
  end
end
