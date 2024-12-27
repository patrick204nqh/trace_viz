# frozen_string_literal: true

require_relative "base_formatter"
require "trace_viz/utils/format_utils"

module TraceViz
  module Loggers
    module TraceFormatters
      class MethodCallFormatter < BaseFormatter
        def format
          [
            indent_representation,
            formatted_depth,
            formatted_method_name,
            colorize(source_location_representation, :dim, :light_gray),
            formatted_params,
          ].compact.join(" ")
        end

        private

        def formatted_params
          return unless config.params[:show]

          truncated_params = trace_data.params.transform_values do |value|
            Utils::FormatUtils.truncate_value(value, config.params[:truncate_values])
          end

          colored_params = truncated_params.transform_keys do |key|
            colorize(key.to_s, :light_yellow)
          end.transform_values do |value|
            colorize(value.to_s, :dim, :light_yellow)
          end

          formatted_string = Utils::FormatUtils.format_key_value_pairs(
            colored_params,
            config.params[:mode],
          )

          "(#{formatted_string})"
        end
      end
    end
  end
end
