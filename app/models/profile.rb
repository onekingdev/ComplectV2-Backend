class Profile < ApplicationRecord
  belongs_to :user

  include ImageUploader[:file]
  include ImageUploader[:avatar]
end
