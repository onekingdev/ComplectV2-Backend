class EmployeeSerializer < ApplicationSerializer
  attributes :id,
             :first_name,
             :last_name,
             :invite_email,
             :start_date,
             :disabled_at,
             :disabled_reason,
             :additional_reason,
             :access_person,
             :role,
             :active,
             :user_id,
             :created_at,
             :updated_at
  has_one :profile, serializer: ProfileSerializer
end
