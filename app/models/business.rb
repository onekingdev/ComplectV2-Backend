class Business < ApplicationRecord
  belongs_to :user
  include ImageUploader[:logo]
end
