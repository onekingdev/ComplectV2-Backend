class BusinessSerializer < ApplicationSerializer
  attributes :id,
             :business_name,
             :crd,
             :aum,
             :accounts,
             :time_zone,
             :phone_number,
             :website,
             :address,
             :apt_unit,
             :city,
             :state,
             :zipcode,
             :logo,
             :created_at,
             :updated_at

  def logo
    object.logo_url(:profile)
  end
end
