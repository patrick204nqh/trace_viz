# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Loggers
    module TraceFormatters
      class MethodCallFormatter < BaseFormatter
        def format
          [
            indent_representation,
            # colorize(depth_representation, :cyan),
            formatted_depth,
            formatted_method_name,
            colorize(source_location_representation, :dim, :light_gray),
            colorize(params_representation, :light_yellow),
          ].compact.join(" ")
        end
      end
    end
  end
end
