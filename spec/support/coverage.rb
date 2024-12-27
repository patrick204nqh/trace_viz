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

    minimum_coverage(90)
  end

  at_exit do
    SimpleCov.result.format!
  end

  puts "SimpleCov coverage started..."
end
