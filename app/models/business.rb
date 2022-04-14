class Business < ApplicationRecord
  belongs_to :user
  include ImageUploader[:logo]
  has_many :employees
end
