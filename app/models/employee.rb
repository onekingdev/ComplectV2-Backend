class Employee < ApplicationRecord
  belongs_to :business
  belongs_to :user, optional: true
  has_one :profile, through: :user
  validates :invite_hash, uniqueness: true, allow_blank: true
  validates :invite_email, uniqueness: { scope: :business_id }
  validates :first_name, :last_name, :invite_email, :role, presence: true

  enum role: { basic: 'basic', admin: 'admin', trusted: 'trusted' }
end
