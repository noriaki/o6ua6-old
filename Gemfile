source 'https://rubygems.org'
ruby "2.3.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
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
  gem 'pry-rails'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'prmd', github: 'interagent/prmd'
  gem 'rspec-rails', '~> 3.5'
  gem "factory_girl_rails", "~> 4.0"
  gem "mongoid-rspec", github: "chocoken517/mongoid-rspec"
  gem 'version_bumper'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-bundler', require: false
  gem 'guard-rake'
  gem 'guard-rspec', require: false
  gem 'guard-rails', require: false
  gem 'travis'
  gem 'travis-lint'
  gem 'growl'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'mongoid', '~> 6'
gem 'active_model_serializers'
gem "committee"
gem "haml-rails"
gem "glicko2"

gem "json"
