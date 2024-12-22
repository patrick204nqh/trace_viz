# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Loggers
      class MethodCallFormatter < BaseFormatter
        def format
          [
            indent_if_enabled,
            colorize(depth_if_enabled, :blue),
            colorize(method_name_if_enabled, :light_green),
            colorize(source_location_if_enabled, :dark_gray),
            colorize(params_if_enabled, :yellow),
          ].compact.join(" ")
        end
      end
    end
  end
end
