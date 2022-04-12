class WorkExperience < ApplicationRecord
  belongs_to :profile

  validates :title, :employer, :starts_on, presence: true
  validates :title, :employer, length: { maximum: 255 }
  validates :ends_on, presence: true, unless: -> { is_present? }
  validate :ends_on_must_greater_or_equal_starts_on

  private

  def ends_on_must_greater_or_equal_starts_on
    if starts_on.present? && ends_on.present? && (ends_on < starts_on)
      errors.add(:starts_on, "can't be greater than end date.")
    end
  end
end
