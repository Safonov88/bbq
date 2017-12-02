if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_use_ssl_for_aws = true
    config.fog_directory  = ENV['S3_BUCKET_NAME']
    config.fog_public     = true

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY']
    }
    config.storage = :fog
  end
end