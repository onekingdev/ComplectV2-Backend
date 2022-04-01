require 'swagger_helper'

RSpec.describe 'Share Exam API' do
  path '/api/exams/{exam_id}/share_exams' do
    let(:exam) do 
      Exam.create(
        name: 'test',
        starts_on: '2020-10-10',
        ends_on: '2020-11-10',
        user_id: 1,
        updated_by_id: 1
      )
    end
    get 'Share Exam list' do
      tags 'Share Exams'
      consumes 'application/json'

      response '200', 'return exam list' do
        let(:exam_id) { exam.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['share_exams']).not_to be_nil
        end
      end
    end
    
    post 'Creates a share exam' do
      tags 'Share Exams'
      consumes 'application/json'
      parameter name: :share_exam, in: :body, schema: {
        type: :object,
        properties: {
          invited_email: { type: :string },
          user_id: { type: :integer }
        },
        required: ['invited_email']
      }

      response '201', 'created share exam' do
        let(:exam) do
          {
            invited_email: 'test@gmail.com',
            user_id: 1
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam) { { invited_email: '' } }
        run_test!
      end
    end
  end

  path '/api/exams/{exam_id}/share_exams/${id}' do
    delete 'remove share exam' do
      tags 'Share Exams'
      consumes 'application/json'

      response '200', 'remove share exam' do
        let(:exam_id) { exam.id }
        run_test!
      end
    end
  end
end