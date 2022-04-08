require 'swagger_helper'

RSpec.describe 'Risks API' do
  include ApiHelper
  let(:user) { create(:user) }
  let(:example_risk) { create(:risk, user: user, updated_by: user) }
  let(:token) { get_token(user) }
  
  path '/api/risks' do
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }
    
    get 'Risk list' do
      tags 'risks'
      consumes 'application/json'

      response '200', 'return risk list' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['risks']).not_to be_nil
        end
      end
    end
    
    post 'Creates a risk' do
      tags 'risks'
      consumes 'application/json'
      parameter name: :risk, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          impact: { type: :string },
          likelihood: { type: :string },
          level: { type: :string },
          policy_ids: { type: :array }
        },
        required: ['name', 'impact', 'likelihood', 'level']
      }

      response '201', 'created risk' do
        let(:risk) do
          {
            name: 'risk',
            impact: 'high',
            likelihood: 'high',
            level: 'high'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:risk) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/risks/{id}' do
    parameter name: :id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    
    let(:Authorization) { token }
    let(:id) { example_risk.id }
    
    get 'Retrieves a risk' do
      tags 'Risks'
      produces 'application/json'

      response '200', 'risk found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            impact: { type: :string },
            likelihood: { type: :string },
            level: { type: :string }
          }
        run_test!
      end

      response '404', 'risk not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Update risk' do
      tags 'Risks'
      consumes 'application/json'
      parameter name: :risk, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          impact: { type: :string },
          likelihood: { type: :string },
          level: { type: :string }
        }
      }

      response '200', 'updated risk' do
        let(:risk) do
          {
            name: 'new risk',
            impact: 'high',
            likelihood: 'high',
            level: 'high',
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:risk) { { name: '' } }
        run_test!
      end
    end

    delete 'Delete risk' do
      tags 'Risks'
      consumes 'application/json'
      response '200', 'deleted risk' do
        run_test!
      end
    end
  end
end