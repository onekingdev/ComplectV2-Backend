require "rails_helper"

RSpec.describe PublishPolicyService do
  let(:user) { create(:user) }
  let(:policy) { create(:policy) }
  let(:policy_params) do
    {
      name: 'new policy name'
    }
  end

  subject(:service) { described_class.new(policy_params, policy, user) }

  describe "#process" do
    it 'updates the status policy' do
      service.process

      expect(policy.status).to eq('published')
    end

    it 'update policy' do
      service.process

      expect(policy.name).to eq('new policy name')
    end
  end
end