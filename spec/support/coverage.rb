# frozen_string_literal: true

if ENV["COVERAGE"]
  require "simplecov"
  require "simplecov-lcov"

  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.output_directory = "coverage"
    c.report_with_single_file = true
    c.lcov_file_name = "lcov.info"
  end
  SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter

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
