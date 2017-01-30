module Aws
  module S3
    @@bucket_name = ENV["AWS_S3_BUCKET_NAME"] || "o6ua6"
    mattr_reader :bucket_name
  end
end

Aws.config.update(
  {
    region: "ap-northeast-1",
    credentials: Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']
    ),
    s3: Rails.env.test? ? { stub_responses: true } : nil
  }
)
