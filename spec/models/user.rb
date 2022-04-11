require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:exam_requests) }
    it { should have_many(:share_exams) }
    it { should have_many(:share_exams) }
    it { should have_many(:work_experiences) }
  end
end
