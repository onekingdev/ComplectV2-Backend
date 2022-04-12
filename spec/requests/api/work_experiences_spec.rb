require 'swagger_helper'
RSpec.describe 'Api::WorkExperiences', type: :request do
  include ApiHelper
  # let(:user) { User.create(email: 'complect@gmail.com', password: '123456789', confirmed_at: Time.current, kind: 'specialist') }
  # let(:profile) { user.profile.create(first_name: 'David', last_name: 'Smith') }
  let(:user) do
    user = User.create(email: 'complect@gmail.com', password: '123456789', confirmed_at: Time.current, kind: 'specialist')
    user.create_profile(first_name: 'David', last_name: 'Smith')

    user
  end
  let(:token) { get_token(user) }
  
  path '/api/work_experiences' do
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }

    get 'Work Experience list' do
      tags 'Work Experiences'
      consumes 'application/json'

      response '200', 'return work_experience list' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['work_experiences']).not_to be_nil
        end
      end
    end
    
    post 'Creates a work_experience' do
      tags 'Work Experiences'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :work_experience, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          employer: { type: :string },
          starts_on: { type: :string },
          ends_on: { type: :string },
          is_present: { type: :boolean },
          description: { type: :string }
        },
        required: ['title', 'employer', 'starts_on', 'ends_on']
      }

      response '201', 'created work_experience' do
        let(:work_experience) do
          {
            title: 'test',
            employer: 'complect',
            starts_on: Time.current - 1.year,
            ends_on: Time.current - 10.days
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:work_experience) { { title: 'test' } }
        run_test!
      end
    end
  end

  path '/api/work_experiences/{id}' do
    parameter name: 'Authorization', in: :header, type: :string
    parameter name: :id, in: :path, type: :integer

    let(:Authorization) { token }
    let(:id) { user_work_experience.id }
    let(:user_work_experience) do
      WorkExperience.create(
        title: 'Ruby',
        employer: 'Complect',
        starts_on: Time.current - 1.year,
        ends_on: Time.current - 4.months,
        profile: user.profile
      )
    end

    get 'Retrieves a work_experience' do
      tags 'Work Experiences'
      produces 'application/json'

      response '200', 'Work Experience found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            employer: { type: :string },
            starts_on: { type: :string },
            ends_on: { type: :string },
            is_present: { type: :boolean },
            description: { type: :string }
          }
        run_test!
      end

      response '404', 'work_experience not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Update Work Experience' do
      tags 'Work Experiences'
      consumes 'application/json'
      parameter name: :work_experience, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          employer: { type: :string },
          starts_on: { type: :string },
          ends_on: { type: :string },
          is_present: { type: :boolean },
          description: { type: :string }
        }
      }

      response '200', 'updated work_experience' do
        let(:work_experience) do
          {
            title: 'ruby'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:work_experience) { { title: '' } }
        run_test!
      end
    end

    delete 'Delete Work Experience' do
      tags 'Work Experiences'
      consumes 'application/json'
      response '200', 'deleted work_experience' do
        run_test!
      end
    end
  end
end