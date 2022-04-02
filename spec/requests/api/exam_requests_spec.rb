require 'swagger_helper'

RSpec.describe 'Exam Request API' do
  let(:user) { User.create(email: 'test@gmail.com', password: '123456789') }
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
            exam_id: exam.id,
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

  path '/api/exam_requests/{id}' do
    parameter name: :id, in: :path, type: :integer
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