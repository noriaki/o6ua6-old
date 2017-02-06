## move config/application.rb and config/environments/production.rb
# Rails.application.config.action_controller.asset_host = proc do
#   Rails.env.production? ? "#{Aws::S3.bucket_name}.s3.amazonaws.com" : 'localhost:8080'
# end

module AssetUrlHelperWithManifest
  def compute_asset_path(source, options = {})
    filename = Rails.env.production? ? 'manifest.json' : 'manifest-development.json'
    File.open(Rails.root.join('app', 'assets', 'config', filename)) do |manifest|
      source = JSON.parse(manifest.read)[source.to_s] || source
    end
    super(source, options)
  end
end
ActionView::Base.prepend AssetUrlHelperWithManifest
