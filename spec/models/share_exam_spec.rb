require 'rails_helper'

RSpec.describe ShareExam, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:exam) }
    it { should belong_to(:updated_by).class_name('User').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:invited_email) }
    it { should validate_uniqueness_of(:invited_email).case_insensitive }
    it { should allow_value('test@gmail.com').for(:invited_email) }
  end
end
