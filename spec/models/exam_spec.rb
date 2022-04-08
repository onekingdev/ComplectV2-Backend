require 'rails_helper'

RSpec.describe Exam, type: :model do
  let(:user) { create(:user) }
  let(:exam) { create(:exam) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:updated_by).class_name('User') }
    it { should have_many(:exam_requests) }
    it { should have_many(:share_exams) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_presence_of(:starts_on) }
    it { should validate_presence_of(:ends_on) }
  end

  it do
    should define_enum_for(:status).
      with_values(
        "inprogress": "inprogress",
        "completed": "completed"
      ).
      backed_by_column_of_type(:string)
  end

  it 'start date cannot be in the past' do
    exam = Exam.create(starts_on: Time.current - 1.day)

    expect(exam.errors.messages[:starts_on]).to eq(["can't be in the past"])
  end

  it 'end date must greater or equal start date' do
    exam = Exam.create(starts_on: Time.current + 10.day, ends_on: Time.current + 1.day)
    expect(exam.errors.messages[:starts_on]).to eq(["can't be greater than end date."])
  end

  it 'auto generate share_uuid after create' do
    expect(exam.share_uuid).not_to be_nil
  end
end
