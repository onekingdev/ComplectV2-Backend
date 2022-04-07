class Policy < ApplicationRecord
  belongs_to :user
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'
  belongs_to :published_by, class_name: 'User', foreign_key: 'published_by_id', optional: true
  belongs_to :archived_by, class_name: 'User', foreign_key: 'archived_by_id', optional: true

  enum status: {
    'draft': 'draft',
    'published': 'published',
    'archived': 'archived'
  }

  after_commit :update_position, on: :create

  private

  def update_position
    update(position: id)
  end
end
