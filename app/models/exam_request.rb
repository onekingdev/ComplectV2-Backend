class ExamRequest < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'
  belongs_to :shared_by, class_name: 'User', foreign_key: 'shared_by_id', optional: true

  validates :name, presence: true, length: { maximum: 255 }
end
