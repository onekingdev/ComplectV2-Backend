FactoryBot.define do
  factory :share_exam do
    invited_email { "user-#{Time.current.to_i}@example.com" }
    exam
    user
    updated_by { user }
  end
end