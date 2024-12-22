# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Loggers
      class MethodReturnFormatter < BaseFormatter
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
