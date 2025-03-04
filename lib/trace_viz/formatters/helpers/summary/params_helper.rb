# frozen_string_literal: true

require "trace_viz/utils"

module TraceViz
  module Formatters
    module Helpers
      module Summary
        module ParamsHelper
          def format_params_template(trace_data, config)
            return unless config.params[:show]

            params_template = build_params_template(trace_data.params, config)
            wrap_params_template(params_template, config)
          end

          private

          def build_params_template(params, config)
            params.transform_values do |value|
              "<#{value.class}>"
            end.then do |formatted_params|
              format_as_string(formatted_params, config.params[:mode])
            end
          end

          def format_as_string(params, mode)
            Utils::Format::KeyValueFormatter.format_pairs(params, mode: mode)
          end

          def wrap_params_template(params_string, config)
            return unless params_string

            truncated = Utils::Format::ValueTruncator.truncate(
              params_string,
              length: config.params[:truncate_length],
            )

            "(#{truncated})"
          end
        end
      end
    end
  end
end
