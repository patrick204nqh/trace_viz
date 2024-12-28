# frozen_string_literal: true

require_relative "base_formatter"
require_relative "helpers/params_helper"
require_relative "helpers/result_helper"

module TraceViz
  module Loggers
    module TraceFormatters
      class MethodCallFormatter < BaseFormatter
        include Helpers::ParamsHelper
        include Helpers::ResultHelper

        def format
          [
            indent_representation,
            format_depth(trace_data, config),
            format_method_name(trace_data, config),
            colorize(source_location_representation, :dim, :light_gray),
            format_params(trace_data, config),
            format_result(trace_data, config),
          ].compact.join(" ")
        end

        private

        def format_result(trace_data, config)
          return unless trace_data.method_return

          super(trace_data.method_return, config)
        end
      end
    end
  end
end
