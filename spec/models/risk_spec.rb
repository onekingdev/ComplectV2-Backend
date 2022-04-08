require 'rails_helper'

RSpec.describe Risk, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:updated_by).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:impact) }
    it { should validate_presence_of(:likelihood) }
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
  end
end
