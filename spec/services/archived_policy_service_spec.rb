require "rails_helper"

RSpec.describe ArchivedPolicyService do
  let(:user) { create(:user) }
  let(:policy) { create(:policy) }
  let(:is_archived) { true }

  subject(:service) { described_class.new(is_archived, policy, user) }

  describe "#process" do
    context 'when archived' do
      it 'updates the status policy to archived' do
        service.process

        expect(policy.status).to eq('archived')
      end
    end

    context 'when unarchived' do
      let(:is_archived) { false }

      it 'updates the status policy to draft' do
        service.process

        expect(policy.status).to eq('draft')
      end      
    end
  end
end