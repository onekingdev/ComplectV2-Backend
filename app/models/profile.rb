class Profile < ApplicationRecord
  belongs_to :user
  has_many :work_experiences

  acts_as_taggable_on :regulatory_bodies
  validates :first_name, presence: true
  validates :last_name, presence: true

  include ImageUploader[:file]
  include ImageUploader[:avatar]

  enum experience: { junior: 'junior', intermediate: 'intermediate', expert: 'expert' }
end
