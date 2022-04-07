require 'swagger_helper'
RSpec.describe 'Exams API', type: :request do
  include ApiHelper
  let(:example_exam) { Exam.create(name: 'test', starts_on: Time.current, ends_on: Time.current + 10.days, user: user, updated_by: user ) }
  let(:user) { User.create(email: 'complect@gmail.com', password: '123456789', confirmed_at: Time.current) }
  let(:token) { get_token(user) }
  
  path '/api/exams' do
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }

    get 'Exam list' do
      tags 'Exams'
      consumes 'application/json'

      response '200', 'return exam list' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['exams']).not_to be_nil
        end
      end
    end
    
    post 'Creates a exam' do
      tags 'Exams'
      consumes 'application/json'
      parameter name: :exam, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          starts_on: { type: :string },
          ends_on: { type: :string }
        },
        required: ['name', 'starts_on', 'ends_on']
      }

      response '201', 'created exam' do
        let(:exam) do
          {
            name: 'test',
            starts_on: Time.current + 1.day,
            ends_on: Time.current + 10.days
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam) { { name: 'test' } }
        run_test!
      end
    end
  end

  path '/api/exams/{id}' do
    parameter name: 'Authorization', in: :header, type: :string
    parameter name: :id, in: :path, type: :integer

    let(:Authorization) { token }
    let(:id) { example_exam.id }
    get 'Retrieves a exam' do
      tags 'Exams'
      produces 'application/json'

      response '200', 'Exam found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            starts_on: { type: :string },
            ends_on: { type: :string }
          }
        run_test!
      end

      response '404', 'exam not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Update Exam' do
      tags 'Exams'
      consumes 'application/json'
      parameter name: :exam, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          starts_on: { type: :string },
          ends_on: { type: :string }
        }
      }

      response '200', 'updated exam' do
        let(:exam) do
          {
            name: 'test',
            starts_on: Time.current + 1.day,
            ends_on: Time.current + 10.days,
            user_id: user.id,
            updated_by_id: user.id
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam) { { name: '' } }
        run_test!
      end
    end

    delete 'Delete Exam' do
      tags 'Exams'
      consumes 'application/json'
      response '200', 'deleted exam' do
        run_test!
      end
    end
  end

  path '/api/exams/{id}/completed' do
    parameter name: :id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    
    let(:Authorization) { token }
    let(:id) { example_exam.id }
    post 'Completed exam' do
      tags 'Exams'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          completed: { type: :boolean }
        }
      }

      response '200', 'completed exam' do
        let(:params) { { completed: true } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['exam']['completed_at']).not_to be_nil
        end
      end
    end

    post 'Uncompleted exam' do
      tags 'Exams'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          completed: { type: :boolean }
        }
      }

      response '200', 'uncompleted exam' do
        let(:params) { { completed: false } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['exam']['completed_at']).to be_nil
        end
      end      
    end
  end
end