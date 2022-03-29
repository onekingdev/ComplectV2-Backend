require 'swagger_helper'

RSpec.describe 'CSV API' do
    path "/api/csv" do
        post "Generate CSV" do
            tags "CSV"
            consumes "application/json"
            parameter name: :csv, in: :body, schema: {
                type: :object,
                properties: {
                    filename: { type: :string }
                },
                required: ["filename"]
            }
            response '201', 'csv generated' do
                let(:csv) {{ filename: 'test.csv' }}
                run_test!
            end
            response '422', 'csv generated' do
                let(:csv) {{  }}
                run_test!
            end
        end
    end
end
