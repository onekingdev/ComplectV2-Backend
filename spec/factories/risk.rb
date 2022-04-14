FactoryBot.define do
  factory :risk do
    name { 'risk' }
    impact { 'high' }
    likelihood { 'high' }
    level { 'high' }
    user
    updated_by { user }
  end
end