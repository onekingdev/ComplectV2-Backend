require 'swagger_helper'

RSpec.describe 'Policies API' do
  include ApiHelper
  let(:user) { create(:user) }
  let(:example_policy) { create(:policy, user: user, updated_by: user) }
  let(:example_policy_2) { create(:policy, user: user, updated_by: user) }
  let(:token) { get_token(user) }
  path '/api/policies' do
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }
    
    get 'Policy list' do
      tags 'Policies'
      consumes 'application/json'

      response '200', 'return policy list' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['policies']).not_to be_nil
        end
      end
    end
    
    post 'Creates a policy' do
      tags 'Policies'
      consumes 'application/json'
      parameter name: :policy, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          status: { type: :string }
        },
        required: ['name']
      }

      response '201', 'created policy' do
        let(:policy) do
          {
            name: 'policy',
            impact: 'high',
            likelihood: 'high',
            level: 'high'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:policy) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/policies/update_position' do
    parameter name: 'Authorization', in: :header, type: :string
    let(:Authorization) { token }

    post 'update position' do
      tags 'Policies'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          positions: { type: :array }
        }
      }
      response '200', 'updated position' do
        let(:params) do
          {
            positions: [
              { "id": example_policy_2.id, "position": example_policy.position },
              { "id": example_policy.id, "position": example_policy_2.position }
            ]
          }
        end
        run_test!
      end
    end
  end

  path '/api/policies/{id}' do
    parameter name: :id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    
    let(:Authorization) { token }
    let(:id) { example_policy.id }
    
    get 'Retrieves a policy' do
      tags 'Policies'
      produces 'application/json'

      response '200', 'policy found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            status: { type: :string }
          }
        run_test!
      end

      response '404', 'policy not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Update policy' do
      tags 'Policies'
      consumes 'application/json'
      parameter name: :policy, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          status: { type: :string }
        }
      }

      response '200', 'updated policy' do
        let(:policy) do
          {
            name: 'new policy'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:policy) { { name: '' } }
        run_test!
      end
    end

    delete 'Delete policy' do
      tags 'Policies'
      consumes 'application/json'
      response '200', 'deleted policy' do
        run_test!
      end
    end
  end

  path '/api/policies/{id}/published' do
    parameter name: :id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    
    let(:Authorization) { token }
    let(:id) { example_policy.id }
    
    post 'Published Policy' do
      tags 'Policies'
      consumes 'application/json'

      parameter name: :policy, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        }
      }

      response '200', 'published policy' do
        let(:policy) { { name: 'change name policy' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['policy']['status']).to eq('published')
        end
      end
    end
  end

  path '/api/policies/{id}/archived' do
    parameter name: :id, in: :path, type: :integer
    parameter name: 'Authorization', in: :header, type: :string
    
    let(:Authorization) { token }
    let(:id) { example_policy.id }

    post 'Archived/Unarchived policy' do
      tags 'Policies'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          archived: { type: :boolean }
        },
        description: 'Set true for archived and false for unarchived'
      }

      response '200', 'archived policy' do
        let(:params) { { archived: true } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['policy']['status']).to eq('archived')
        end
      end

      response '422', 'can not archived' do
        let(:params) { {} }
        run_test!
      end
    end
  end
end