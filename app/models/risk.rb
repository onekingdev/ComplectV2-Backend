class Risk < ApplicationRecord
  belongs_to :user
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'
  has_many :risk_policies
  has_many :policies, through: :risk_policies

  validates :name, :impact, :likelihood, :level, presence: true
  validates :name, length: { maximum: 255 }, uniqueness: { scope: :business_id }

  enum impact: {
    'low': 'low',
    'medium': 'medium',
    'high': 'high'
  }, _suffix: true

  enum likelihood: {
    'low': 'low',
    'medium': 'medium',
    'high': 'high'
  }, _suffix: true

  enum level: {
    'low': 'low',
    'medium': 'medium',
    'high': 'high'
  }, _suffix: true

  before_destroy { policies.clear }

  accepts_nested_attributes_for :policies
end
