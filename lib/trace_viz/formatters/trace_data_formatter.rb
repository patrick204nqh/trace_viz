# frozen_string_literal: true

require_relative "base_formatter"
require_relative "helpers/indent_helper"
require_relative "helpers/depth_helper"
require_relative "helpers/time_helper"
require_relative "helpers/params_helper"
require_relative "helpers/source_helper"
require_relative "helpers/result_helper"
require_relative "helpers/method_details_helper"

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
        @config = @trace_data.config
      end

      private

      attr_reader :trace_data, :config
    end
  end
end
