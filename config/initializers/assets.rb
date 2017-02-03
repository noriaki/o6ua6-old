Rails.application.config.action_controller.asset_host = proc do
  Rails.env.production? ? "#{Aws::S3.bucket_name}.s3.amazonaws.com" : 'localhost:8080'
end
