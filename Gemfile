# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in trace_viz.gemspec
gemspec

group :development do
  gem "rake", "~> 13.0"
  gem "rubocop", "~> 1.65"
  gem "rubocop-shopify", "~> 2.15.1"
  gem "steep", "~> 1.9.3"
end

group :test do
  gem "rspec", "~> 3.0"
  gem "simplecov", "~> 0.22", require: false
  gem "simplecov-lcov", "~> 0.8.0", require: false
end

group :development, :test do
  gem "bundler-audit", "~> 0.9"
end
