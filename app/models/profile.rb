class Profile < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :regulatory_bodies
  validates :first_name, presence: true
  validates :last_name, presence: true

  include ImageUploader[:file]
  include ImageUploader[:avatar]
end