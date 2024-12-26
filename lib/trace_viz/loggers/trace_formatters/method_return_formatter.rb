# frozen_string_literal: true

require "trace_viz/utils/format_utils"
require_relative "base_formatter"

module TraceViz
  module Loggers
    module TraceFormatters
      class MethodReturnFormatter < BaseFormatter
        def format
          [
            indent_representation,
            formatted_depth,
            formatted_method_name,
            formatted_result,
            colorize(source_location_representation, :dark_gray),
            colorize(execution_time_representation, :red),
          ].compact.join(" ")
        end

        private

        def formatted_result
          return unless config.result[:show]

          truncated_result = Utils::FormatUtils.truncate_value(
            trace_data.result.inspect,
            config.result[:truncate_length],
          )

          prefix = colorize("#=>", :dip, :italic, :light_blue)
          result = colorize(truncated_result, :dip, :gray)

          [
            prefix,
            result,
          ].join(" ")
        end
      end
    end
  end
end
