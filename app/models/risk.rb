class Risk < ApplicationRecord
  belongs_to :user
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'

  validates :name, :impact, :likelihood, :level, presence: true
  validates :name, length: { maximum: 255 }

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
end
