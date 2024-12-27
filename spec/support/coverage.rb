# frozen_string_literal: true

if ENV["CI"]
  require "simplecov"

  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::SimpleFormatter,
  ]

  SimpleCov.start do
    add_filter "/spec/"
    track_files "{lib}/**/*.rb"
  end

  puts "SimpleCov coverage started..."
end
