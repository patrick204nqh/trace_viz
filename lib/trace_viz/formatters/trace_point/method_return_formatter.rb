# frozen_string_literal: true

require "trace_viz/formatters/trace_point/base_formatter"

module TraceViz
  module Formatters
    module TracePoint
      class MethodReturnFormatter < TraceViz::Formatters::BaseFormatter
        def format
          [
            indent_if_enabled,
            colorize(depth_if_enabled, :blue),
            colorize(method_name_if_enabled, :light_green),
            colorize(result_if_enabled, :cyan),
            colorize(source_location_if_enabled, :dark_gray),
            colorize(execution_time_if_enabled, :red),
          ].compact.join(" ")
        end
      end
    end
  end
end
