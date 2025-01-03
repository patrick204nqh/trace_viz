# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Log
      class SummaryGroupFormatter < BaseFormatter
        include Helpers::Log::DepthHelper
        include Helpers::Log::MethodNameHelper
        include Helpers::Log::Summary::ParamsHelper

        def call(trace_data)
          [
            indent_representation(trace_data),
            format_depth(trace_data, config),
            format_method_name(trace_data, config),
            format_params_template(trace_data, config),
            summary_info(trace_data),
          ].compact.join(" ")
        end

        private

        def summary_info(trace_data)
          colorize(
            "[Summary: #{trace_data.count} calls | Avg Time: #{format(
              "in %.6fms",
              trace_data.average_duration,
            )}]",
            :bold,
            :italic,
            :yellow,
          )
        end
      end
    end
  end
end
