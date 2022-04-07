require 'swagger_helper'

RSpec.describe 'Share Exam API' do
  include ApiHelper
  let(:user) { User.create(email: 'complect@gmail.com', password: '123456789', confirmed_at: Time.current) }
  let(:token) { get_token(user) }
  let(:exam) do
    Exam.create(
      name: 'test',
      starts_on: Time.current,
      ends_on: Time.current + 3.days,
      user_id: user.id,
      updated_by_id: user.id
    )
  end

  path '/api/exams/{exam_id}/share_exams' do
    parameter name: :exam_id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }
    
    get 'Share Exam list' do
      tags 'Share Exams'
      consumes 'application/json'

      response '200', 'return share exam list' do
        let(:exam_id) { exam.id }
        run_test!
      end
    end
    
    post 'Creates a share exam' do
      tags 'Share Exams'
      consumes 'application/json'
      parameter name: :share_exam, in: :body, schema: {
        type: :object,
        properties: {
          invited_email: { type: :string }
        },
        required: ['invited_email']
      }

      response '201', 'created share exam' do
        let(:exam_id) { exam.id }
        let(:share_exam) do
          {
            invited_email: 'test@gmail.com',
            user_id: user.id
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:exam_id) { exam.id }
        let(:share_exam) { { invited_email: '' } }
        run_test!
      end
    end
  end

  path '/api/exams/{exam_id}/share_exams/{id}' do
    parameter name: :exam_id, in: :path, type: :integer
    parameter name: :id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }
    
    delete 'remove share exam' do
      tags 'Share Exams'
      consumes 'application/json'

      response '200', 'remove share exam' do
        let(:example_exam_share_exam) do
          ShareExam.create(
            invited_email: 'complect@gmail.com',
            user_id: user.id,
            exam_id: exam.id
          )
        end
        let(:exam_id) { exam.id }
        let(:id) { example_exam_share_exam.id }
        run_test!
      end
    end
  end
end