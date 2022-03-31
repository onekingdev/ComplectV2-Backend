require 'swagger_helper'

RSpec.describe 'Exam Request API' do
  path '/api/exam_requests' do
    post 'Creates a exam request' do
      tags 'Exam Requests'
      consumes 'application/json'
      parameter name: :exam_request, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          details: { type: :string },
          exam_id: { type: :integer },
          user_id: { type: :integer },
          updated_by_id: { type: :integer }
        },
        required: ['name']
      }

      response '201', 'created exam request' do
        let(:exam_request) do
          {
            name: 'test',
            exam_id: 1,
            user_id: 1,
            updated_by_id: 1
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam_request) { { name: '' } }
        run_test!
      end
    end

    patch 'Update Exam Request' do
      tags 'Exam Requests'
      consumes 'application/json'

      parameter name: :exam_request, in: :body, schema: {
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
end