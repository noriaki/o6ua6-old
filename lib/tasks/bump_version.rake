namespace :frontend do
  namespace :bump do
    def bump_version(target, filepath)
      config = JSON.parse(File.read(filepath))
      version = Bumper::Version.new(config['version'])
      version.send("bump_#{target}")
      config['version'] = version.to_s
      File.open(filepath, 'w') do |file|
        file.puts(JSON.pretty_generate(config))
        filename = filepath.relative_path_from(Rails.root)
        puts "version: #{version} (#{filename})"
      end
    end

    def version_files
      [
        Rails.root.join('package.json'),
        Rails.root.join('app', 'frontend', 'package.json')
      ]
    end

    desc 'Bump major (x.0.0.0) of package.json'
    task :major do
      version_files.each { |f| bump_version :major, f }
    end

    desc 'Bump minor (0.x.0.0) of package.json'
    task :minor do
      version_files.each { |f| bump_version :minor, f }
    end

    desc 'Bump revision (0.0.x.0) of package.json'
    task :revision do
      version_files.each { |f| bump_version :revision, f }
    end

    desc 'Bump build (0.0.0.x) of package.json'
    task :build do
      version_files.each { |f| bump_version :build, f }
    end
  end
end

[:major, :minor, :revision, :build].each do |t|
  Rake::Task["bump:#{t}".to_sym].enhance do
    Rake::Task["frontend:bump:#{t}".to_sym].invoke
  end
end
