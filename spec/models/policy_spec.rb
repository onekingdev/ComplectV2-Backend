require 'rails_helper'

RSpec.describe Policy, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:updated_by).class_name('User') }
    it { should belong_to(:published_by).class_name('User').optional }
    it { should belong_to(:archived_by).class_name('User').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
  end

  it 'update position after create' do
    policy = Policy.create(name: 'policy', user: user)

    expect(policy.position).to eq(policy.id)
  end
end
