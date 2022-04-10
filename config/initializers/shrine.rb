require 'shrine'

if Rails.env.production? || Rails.env.staging?
  require 'shrine/storage/s3'

  s3_options = {
    access_key_id: ENV.fetch('AWS_ACCESS_KEY'),
    secret_access_key: ENV.fetch('AWS_SECRET_KEY'),
    region: ENV.fetch('AWS_REGION'),
    bucket: ENV.fetch('AWS_S3_BUCKET')
  }

  Shrine.storages = {
    store: Shrine::Storage::S3.new(prefix: 'store', upload_options: { acl: 'public-read' }, **s3_options),
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options)
  }
else
  require 'shrine/storage/file_system'

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store')
  }
end

Shrine.plugin :keep_files, cached: true, replaced: true
