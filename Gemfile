# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.5"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "bootsnap", ">= 1.4.2", require: false
gem "figaro"
gem "bcrypt"
gem "rack-cors"
gem "jwt"
gem "active_model_serializers", "~> 0.10.10"
gem "kaminari"
gem "faker"
gem "aws-sdk-s3"
gem "google-api-client"
gem "google_drive"
gem "rails-erd"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "listen", "~> 3.2"
  gem "rubocop"
  gem "rubocop-performance"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "faker"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
