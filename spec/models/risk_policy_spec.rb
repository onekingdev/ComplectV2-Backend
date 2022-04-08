require 'rails_helper'

RSpec.describe RiskPolicy, type: :model do
  describe 'associations' do
    it { should belong_to(:risk) }
    it { should belong_to(:policy) }
  end
end
