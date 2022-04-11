require 'rails_helper'

RSpec.describe WorkExperience, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_presence_of(:employer) }
    it { should validate_length_of(:employer).is_at_most(255) }
    it { should validate_presence_of(:starts_on) }
    it { should validate_presence_of(:ends_on) }
  end
end
