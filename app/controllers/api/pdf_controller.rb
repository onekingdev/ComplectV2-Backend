class Api::PdfController < ApplicationController
	def index
		template = params[:template]
		html = ActionController::Base.new.render_to_string({
			template: "pdf/"+template,
			locals: {
				last_updated: "2/23/2022",
				business: {},
				logo: "test.png",
				cpolicy: { business: {} },
				cpconf: {}
			}
		});

		pdf = Grover.new(html, format: 'A4').to_pdf
		obj = S3_BUCKET.object("pdf/"+params[:filename])
		obj.put( body: pdf )
		render json: { success: obj.public_url }
	end
end
