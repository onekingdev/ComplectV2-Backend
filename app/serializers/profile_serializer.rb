class ProfileSerializer < ApplicationSerializer
  attributes :id,
             :first_name
  :last_name
  :time_zone
  :address
  :apt_unit
  :city
  :state
  :phone_number
  :zipcode
  :availability
  :former_regulator
  :hourly_rate
  :avatar
  :file
  :created_at
  :updated_at

  def file
    object.file_url(:profile)
  end

  def avatar
    object.avatar_url(:profile)
  end
end
