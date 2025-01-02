# frozen_string_literal: true

require_relative "base_formatter"
require_relative "helpers"

module TraceViz
  module Formatters
    class TraceDataFormatter < BaseFormatter
      #
      # General formatting methods for TraceData::Base
      # These methods are used to format the output of the trace data
      # based on the configuration settings.
      #

      include Helpers::IndentHelper
      include Helpers::DepthHelper
      include Helpers::TimeHelper
      include Helpers::ParamsHelper
      include Helpers::SourceHelper
      include Helpers::ResultHelper
      include Helpers::MethodDetailsHelper

      def initialize(trace_data)
        super()
        @trace_data = trace_data
      end

      private

      attr_reader :trace_data
    end
  end
end
