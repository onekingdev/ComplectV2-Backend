require 'swagger_helper'

RSpec.describe 'Exam Request API' do
  include ApiHelper
  let(:user) { User.create(email: 'complect@gmail.com', password: '123456789', confirmed_at: Time.current) }
  let(:token) { get_token(user) }
  
  let(:exam) do
    Exam.create(
      name: 'foo',
      starts_on: Time.current,
      ends_on: Time.current + 3.days,
      user_id: user.id,
      updated_by_id: user.id
    )
  end

  let(:example_exam_request) do
    ExamRequest.create(
      {
        name: 'test',
        exam_id: exam.id,
        user_id: user.id,
        updated_by_id: user.id
      }
    )
  end

  path '/api/exams/{exam_id}/exam_requests' do
    parameter name: 'Authorization', in: :header, type: :string
    parameter name: :exam_id, in: :path, type: :integer
    let(:exam_id) { exam.id }
    let(:Authorization) { token }

    post 'Creates a exam request' do
      tags 'Exam Requests'
      consumes 'application/json'
      parameter name: :exam_request, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          details: { type: :string },
          user_id: { type: :integer },
          updated_by_id: { type: :integer }
        },
        required: ['name']
      }

      response '201', 'created exam request' do
        let(:exam_request) do
          {
            name: 'test',
            user_id: user.id,
            updated_by_id: user.id
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam_request) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/exams/{exam_id}/exam_requests/{id}' do
    parameter name: :exam_id, in: :path, type: :integer
    parameter name: :id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }
    let(:exam_id) { exam.id }
    let(:id) { example_exam_request.id }

    put 'Update Exam Request' do
      tags 'Exam Requests'
      consumes 'application/json'

      parameter name: :exam_request, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          details: { type: :string },
          user_id: { type: :integer },
          updated_by_id: { type: :integer }
        }
      }

      response '200', 'updated exam request' do
        let(:exam_request) do
          {
            name: 'ruby',
            starts_on: '2020-10-10'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam_request) { { name: '' } }
        run_test!
      end
    end

    delete 'delete exam request' do
      tags 'Exam Requests'
      consumes 'application/json'

      response '200', 'deleted exam request' do
        run_test!
      end
    end
  end
end