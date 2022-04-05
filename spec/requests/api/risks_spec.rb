require 'swagger_helper'

RSpec.describe 'Risks API' do
  let(:user) { User.create(email: 'test@gmail.com', password: '123456789') }
  let(:riskple_risk) do
    Risk.create(
      name: 'risk',
      impact: 'high',
      likelihood: 'high',
      level: 'high',
      user_id: user.id,
      updated_by_id: user.id
    )
  end
  
  path '/api/risks' do
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
          user_id: { type: :integer },
          updated_by_id: { type: :integer }
        },
        required: ['name', 'impact', 'likelihood', 'level']
      }

      response '201', 'created risk' do
        let(:risk) do
          {
            name: 'risk',
            impact: 'high',
            likelihood: 'high',
            level: 'high',
            user_id: user.id,
            updated_by_id: user.id
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

    let(:id) { riskple_risk.id }
    get 'Retrieves a risk' do
      tags 'risks'
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
      tags 'risks'
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
      tags 'risks'
      consumes 'application/json'
      response '200', 'deleted risk' do
        run_test!
      end
    end
  end
end