# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  add_filter "/spec/"
  track_files "{lib}/**/*.rb"
end

puts "SimpleCov coverage started..." if ENV["CI"]
