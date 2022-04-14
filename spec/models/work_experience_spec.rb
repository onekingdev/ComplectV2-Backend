require 'rails_helper'

RSpec.describe WorkExperience, type: :model do
  let(:user) { User.create(email: 'complect@gmail.com', password: '123456789', confirmed_at: Time.current, kind: 'specialist') }
  let(:profile) { Profile.create(first_name: 'test', last_name: 'complect', user: user) }
  describe 'associations' do
    it { should belong_to(:profile) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_presence_of(:employer) }
    it { should validate_length_of(:employer).is_at_most(255) }
    it { should validate_presence_of(:starts_on) }
    it { should validate_presence_of(:ends_on) }
  end

  it 'ends_on is required if does not exist is_present' do
    work_experience = WorkExperience.create(
      title: 'Ruby',
      employer: 'complect', 
      starts_on: Time.current - 1.year,
      profile: profile
    )
    expect(work_experience.errors.full_messages).to include("Ends on can't be blank")
  end

  it 'ends_on empty when is_present is true' do
    work_experience = WorkExperience.create(
      title: 'Ruby',
      employer: 'complect', 
      starts_on: Time.current - 1.year,
      is_present: true,
      profile: profile
    )

    expect(work_experience.errors.full_messages).to be_empty
  end

  it 'end date must greater or equal start date' do
    work_experience = WorkExperience.create(
      title: 'Ruby',
      employer: 'complect', 
      starts_on: Time.current - 1.year,
      ends_on: Time.current - 2.year,
      profile: profile
    )

    expect(work_experience.errors.full_messages).to include("Starts on can't be greater than end date.")
  end
end
