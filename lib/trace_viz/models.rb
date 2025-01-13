# frozen_string_literal: true

Dir[File.join(__dir__, "models/**/*.rb")].each { |file| require_relative file }

module TraceViz
  module Models
  end
end
