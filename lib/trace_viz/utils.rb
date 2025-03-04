# frozen_string_literal: true

Dir[File.join(__dir__, "utils/**/*.rb")].each { |file| require_relative file }

module TraceViz
  module Utils
  end
end
