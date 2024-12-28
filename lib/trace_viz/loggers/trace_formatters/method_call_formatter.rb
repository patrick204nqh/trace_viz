# frozen_string_literal: true

require_relative "base_formatter"
require_relative "helpers/params_helper"

module TraceViz
  module Loggers
    module TraceFormatters
      class MethodCallFormatter < BaseFormatter
        include Helpers::ParamsHelper

        def format
          [
            indent_representation,
            format_depth(trace_data, config),
            format_method_name(trace_data, config),
            colorize(source_location_representation, :dim, :light_gray),
            format_params(trace_data, config),
          ].compact.join(" ")
        end
      end
    end
  end
end
