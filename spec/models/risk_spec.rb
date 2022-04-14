require 'rails_helper'

RSpec.describe Risk, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:business) }
    it { should belong_to(:updated_by).class_name('User') }
    it { should have_many(:risk_policies) }
    it { should have_many(:policies) }
  end

  describe 'validations' do
    it { should validate_presence_of(:impact) }
    it { should validate_presence_of(:likelihood) }
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
  end

  it do
    should define_enum_for(:impact).
      with_values({
        'low': 'low',
        'medium': 'medium',
        'high': 'high'
      }).backed_by_column_of_type(:string).with_suffix
  end

  it do
    should define_enum_for(:likelihood).
      with_values({
        'low': 'low',
        'medium': 'medium',
        'high': 'high'
      }).backed_by_column_of_type(:string).with_suffix
  end

  it do
    should define_enum_for(:level).
      with_values({
        'low': 'low',
        'medium': 'medium',
        'high': 'high'
      }).backed_by_column_of_type(:string).with_suffix
  end

  it { should accept_nested_attributes_for(:policies) }
end
