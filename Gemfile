source 'https://rubygems.org'
ruby '2.3.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'faraday_middleware', '0.10.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails', '~> 4.0'
  gem 'mongoid-rspec', github: 'chocoken517/mongoid-rspec'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem 'growl'
  gem 'guard-bundler', require: false
  gem 'guard-process', require: false
  gem 'guard-rails', require: false
  gem 'guard-rake', require: false
  gem 'guard-rspec', require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'travis'
  gem 'travis-lint'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'active_model_serializers'
gem 'aws-sdk', '~> 2'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'glicko2'
gem 'gon'
gem 'haml-rails'
gem 'mongoid', '~> 6'
gem 'mongo_session_store-rails4',
    git: 'https://github.com/drgcms/mongo_session_store', branch: 'rails5'
gem 'version_bumper'

gem 'json'
