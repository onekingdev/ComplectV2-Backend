FactoryBot.define do
  factory :policy do
    name { 'policy' }
    description { 'description' }
    user
    updated_by { user }
  end
end