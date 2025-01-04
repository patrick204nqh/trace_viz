# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Export
      class SummaryGroupFormatter < BaseFormatter
        include Helpers::Summary::ParamsHelper
        include Helpers::Summary::SourceHelper

        def call(trace_data)
          [
            indent_representation(trace_data),
            depth_representation(trace_data),
            Defaults::Actions.emoji_for(:processing),
            method_name_representation(trace_data),
            source_location_representation(trace_data),
            format_params_template(trace_data, config),
            summary_info(trace_data),
          ].compact.join(" ")
        end

        private

        def summary_info(trace_data)
          "[Summary: #{trace_data.count} calls | Avg Time: #{format(
            "in %.6fms",
            trace_data.average_duration,
          )}]"
        end
      end
    end
  end
end
