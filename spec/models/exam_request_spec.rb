require 'rails_helper'

RSpec.describe ExamRequest, type: :model do
  describe 'associations' do
    it { should belong_to(:exam) }
    it { should belong_to(:user) }
    it { should belong_to(:updated_by).class_name('User') }
    it { should belong_to(:shared_by).class_name('User').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
  end
end
