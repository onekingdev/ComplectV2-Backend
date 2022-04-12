class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'
  belongs_to :business

  has_many :exam_requests
  has_many :share_exams

  validates :name, :starts_on, :ends_on, presence: true
  validates :name, length: { maximum: 255 }
  validate :starts_on_cannot_be_in_the_past
  validate :ends_on_must_greater_or_equal_starts_on

  after_create :generate_share_uuid

  enum status: {
    'inprogress': 'inprogress',
    'completed': 'completed'
  }

  private

  def starts_on_cannot_be_in_the_past
    if starts_on.present? && starts_on < Date.today
      errors.add(:starts_on, "can't be in the past")
    end
  end

  def ends_on_must_greater_or_equal_starts_on
    if starts_on.present? && ends_on.present? && (ends_on < starts_on)
      errors.add(:starts_on, "can't be greater than end date.")
    end
  end

  def generate_share_uuid
    update(share_uuid: SecureRandom.uuid)
  end
end
