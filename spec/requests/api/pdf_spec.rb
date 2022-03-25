require 'swagger_helper'

RSpec.describe 'PDF API' do
    path "/api/pdf" do
        post "Generate PDF" do
            tags "PDF"
            consumes "application/json"
            parameter name: :pdf, in: :body, schema: {
                type: :object,
                properties: {
                    filename: { type: :string },
                    template: { type: :string }
                },
                required: ["filename"]
            }
            response '201', 'pdf generated' do
                let(:pdf) {{ filename: 'test.pdf' }}
                run_test!
            end
            response '422', 'error' do
                let(:pdf) {{  }}
                run_test!
            end
        end
    end
end
