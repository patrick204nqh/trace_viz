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
            format_depth,
            format_method_name,
            colorize(source_location_representation, :dim, :light_gray),
            format_params,
          ].compact.join(" ")
        end

        private

        def format_params
          return unless config.params[:show]

          params = prepare_params(trace_data.params)
          wrap_params(params)
        end

        def prepare_params(params)
          params
            .then { |p| truncate_values(p, config.params[:truncate_values]) }
            .then { |p| colorize_keys_and_values(p) }
            .then { |p| format_as_string(p) }
        end

        def truncate_values(params, length)
          return params unless length

          params.transform_values { |value| Utils::FormatUtils.truncate_value(value, length) }
        end

        def colorize_keys_and_values(params)
          params.transform_keys { |key| colorize(key.to_s, :light_yellow) }
            .transform_values { |value| colorize(value.to_s, :dim, :light_yellow) }
        end

        def format_as_string(params)
          Utils::FormatUtils.format_key_value_pairs(params, config.params[:mode])
        end

        def wrap_params(params_string)
          return unless params_string

          truncated = Utils::FormatUtils.truncate_value(params_string, config.params[:truncate_length])
          "(#{truncated})"
        end
      end
    end
  end
end
