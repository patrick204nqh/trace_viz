# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Loggers
    module TraceFormatters
      class MethodReturnFormatter < BaseFormatter
        def format
          [
            indent_representation,
            # colorize(depth_representation, :cyan),
            formatted_depth,
            formatted_method_name,
            colorize(result_representation, :cyan),
            colorize(source_location_representation, :dark_gray),
            colorize(execution_time_representation, :red),
          ].compact.join(" ")
        end
      end
    end
  end
end
