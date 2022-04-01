require 'swagger_helper'

RSpec.describe 'Exams API' do
  path '/api/exams' do
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
          ends_on: { type: :string },
          user_id: { type: :integer },
          updated_by_id: { type: :integer }
        },
        required: ['name', 'starts_on', 'ends_on']
      }

      response '201', 'created exam' do
        let(:exam) do
          {
            name: 'test',
            starts_on: '2020-10-10',
            ends_on: '2020-11-10',
            user_id: 1,
            updated_by_id: 1
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam) { { name: 'test' } }
        run_test!
      end
    end

    patch 'Update Exam' do
      tags 'Exams'
      consumes 'application/json'

      parameter name: :exam, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          starts_on: { type: :string },
          ends_on: { type: :string },
          user_id: { type: :integer },
          updated_by_id: { type: :integer }
        }
      }

      response '200', 'created exam' do
        let(:exam) do
          {
            name: 'ruby',
            starts_on: '2020-10-10'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/exams/{id}' do
    get 'Retrieves a exam' do
      tags 'Exams'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Exam found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            starts_on: { type: :string },
            ends_on: { type: :string }
          }

        let(:id) { Exam.create(name: 'foo', starts_on: Time.now.current, ends_on: Time.now.current + 3.days, user_id: User.first.id, updated_by_id: User.first.id).id }
        run_test!
      end
    end
  end
end