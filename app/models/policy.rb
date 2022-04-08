class Policy < ApplicationRecord
  belongs_to :user
  belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by_id'
  belongs_to :published_by, class_name: 'User', foreign_key: 'published_by_id', optional: true
  belongs_to :archived_by, class_name: 'User', foreign_key: 'archived_by_id', optional: true
  belongs_to :source_version, class_name: 'Policy', foreign_key: :src_id, optional: true
  
  enum status: {
    'draft': 'draft',
    'published': 'published',
    'archived': 'archived'
  }

  validates :name, presence: true, length: { maximum: 255 }

  after_commit :update_position, on: :create

  scope :root, -> { where(src_id: nil).order('position') }

  private

  def update_position
    update(position: id)
  end
end
