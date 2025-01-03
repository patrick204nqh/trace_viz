# frozen_string_literal: true

Dir[File.join(__dir__, "steps/**/*.rb")].each { |file| require_relative file }

module TraceViz
  module Collectors
    module Steps
    end
  end
end
