# frozen_string_literal: true

Dir[File.join(__dir__, "shared/**/*.rb")].each { |file| require_relative file }

module TraceViz
  module Shared
  end
end
