FactoryBot.define do
  factory :exam_request do
    name { 'Change header' }
    exam
    user
    updated_by { user }
  end
end