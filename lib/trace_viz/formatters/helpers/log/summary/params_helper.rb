# frozen_string_literal: true

require "trace_viz/utils/format_utils"

module TraceViz
  module Formatters
    module Helpers
      module Log
        module Summary
          module ParamsHelper
            def format_params_template(trace_data, config)
              return unless config.params[:show]

              params = prepare_params(trace_data.params, config)
              wrap_params(params, config)
            end

            private

            def prepare_params(params, config)
              params
                .then { |p| truncate_values(p, config.params[:truncate_values]) }
                .then { |p| colorize_keys_and_values(p) }
                .then { |p| format_as_string(p, config.params[:mode]) }
            end

            def truncate_values(params, length)
              return params unless length

              params.transform_values { |value| Utils::FormatUtils.truncate_value(value, length) }
            end

            def colorize_keys_and_values(params)
              params.transform_keys { |key| colorize_for(key.to_s, :trace_params_key) }
                .transform_values { |value| colorize("<#{value.class}>", :yellow) }
            end

            def format_as_string(params, mode)
              Utils::FormatUtils.format_key_value_pairs(params, mode)
            end

            def wrap_params(params_string, config)
              return unless params_string

              truncated = Utils::FormatUtils.truncate_value(params_string, config.params[:truncate_length])
              "(#{truncated})"
            end
          end
        end
      end
    end
  end
end
