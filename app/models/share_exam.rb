class ShareExam < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id', optional: true

  validates :invited_email, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :invited_email, with: Devise.email_regexp
end
