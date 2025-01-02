# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Log
      class VerboseFormatter < BaseFormatter
        include Helpers::Log::Verbose::DepthHelper
        include Helpers::Log::Verbose::MethodNameHelper
      end
    end
  end
end
