if Rails.env == "production"
  Aws.config.update({
                      region: ENV['AWS_REGION'],
                      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_KEY'])
                    })

  S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_S3_BUCKET'])
end
