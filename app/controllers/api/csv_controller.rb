class Api::CsvController < ApplicationController
	def index
		require 'csv'
		obj = S3_BUCKET.object("csv/"+params[:filename])
		csvdata = [
			["Name","Linked To","Creator","Assignee","Start Date","Due Date","Complete Date","Over Due","Description","Comments","Attachments"],
			["TTT","1","Dim","Pablo","2/23/2022","4/23/2022","4/23/2022","3","This is test","wonderful","2"],
			["SSS","2","Manuel","Perez","3/23/2022","4/23/2022","4/23/2022","3","This is test","wonderful","3"],
		]
		file_csv = CSV.generate do |csv|
			csvdata.each do |line|
				csv << line
			end
		end
		obj.put( body: file_csv )
		render json: { success: obj.public_url }
	end
end