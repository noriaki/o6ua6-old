source "https://rubygems.org"

gem "rails", "~> 5.0.0", ">= 5.0.0.1"
gem "puma", "~> 3.0"

group :development, :test do
  gem "byebug", platform: :mri
  gem "pry-rails"
  gem "dotenv-rails", require: "dotenv/rails-now"
  gem "prmd", git: "https://github.com/interagent/prmd"
  gem "rspec-rails", "~> 3.5"
  gem "factory_girl_rails", "~> 4.0"
  gem "mongoid-rspec", git: "https://github.com/chocoken517/mongoid-rspec", ref: "f6d6b6d"
end

group :test do
  gem "database_cleaner"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "guard-bundler", require: false
  gem "guard-rake"
  gem "guard-rspec", require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'mongoid', '~> 6'
gem 'active_model_serializers'
gem "committee"
