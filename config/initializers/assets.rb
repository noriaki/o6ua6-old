Rails.application.config.action_controller.asset_host = proc do
  Rails.env.production? ? "#{Aws::S3.bucket_name}.s3.amazonaws.com" : 'localhost:8080'
end

module AssetUrlHelperWithManifest
  def compute_asset_path(source, options = {})
    File.open(Rails.root.join('app', 'assets', 'config', 'manifest.json')) do |manifest|
      source = JSON.parse(manifest.read)[source.to_s] || source
    end
    super(source, options)
  end
end
ActionView::Base.prepend AssetUrlHelperWithManifest
