# frozen_string_literal: true

require "simplecov"
require "simplecov-json"

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/config/"
  track_files "{app,lib}/**/*.rb"
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
end

puts "SimpleCov coverage started..." if ENV["CI"]
