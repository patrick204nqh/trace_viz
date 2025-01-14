# frozen_string_literal: true

require "trace_viz/utils"

module TraceViz
  module Formatters
    module Helpers
      module ParamsHelper
        def params_representation(trace_data)
          return unless config.params[:show]

          params = process_params(trace_data.params, config)
          wrap_params_string(params, config)
        end

        private

        def process_params(params, config)
          params
            .then { |p| truncate_param_values(p, config.params[:truncate_values]) }
            .then { |p| stringify_params(p, config.params[:mode]) }
        end

        def truncate_param_values(params, max_length)
          return params unless max_length

          params.transform_values { |value| Utils::Format::ValueTruncator.truncate(value, length: max_length) }
        end

        def stringify_params(params, mode)
          Utils::FormatUtils.format_key_value_pairs(params, mode)
        end

        def wrap_params_string(params_string, config)
          return unless params_string

          truncated_string = Utils::Format::ValueTruncator.truncate(
            params_string,
            length: config.params[:truncate_length],
          )

          "(#{truncated_string})"
        end
      end
    end
  end
end
