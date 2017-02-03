namespace :assets do
  def asset_files
    targets = %w(images javascripts stylesheets)
    Pathname.glob(
      Rails.root.join('app', 'assets', "{#{targets.join(',')}}", '*')
    )
  end

  desc 'Release all assets'
  task release: ['assets:build', 'assets:stage']

  desc 'Remove all assets'
  task :clean do
    asset_files.each(&:delete)
  end

  desc 'Build assets by webpack'
  task build: ['assets:clean', :environment] do
    cd 'app/frontend' do
      sh 'yarn install'
      sh format('NODE_ENV=%{env} yarn build', env: Rails.env)
    end
  end

  desc 'Stage all assets to AWS S3 bucket'
  task stage: :environment do
    s3 = Aws::S3::Bucket.new(Aws::S3.bucket_name)
    asset_files.each do |path|
      next unless path.file?
      object_key = "#{path.dirname.basename}/#{path.basename}"
      path.open do |file|
        s3.object(object_key).put(acl: 'public-read', body: file.read)
      end
    end
  end
end
