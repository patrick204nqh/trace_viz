# frozen_string_literal: true

require "trace_viz/utils/format_utils"

module TraceViz
  module Formatters
    module Helpers
      module ParamsHelper
        def params_representation
          return unless config.params[:show]

          truncated_params = trace_data.params.transform_values do |value|
            Utils::FormatUtils.truncate_value(value, config.params[:truncate_values])
          end

          formatted_values = Utils::FormatUtils.format_key_value_pairs(
            truncated_params,
            config.params[:mode],
          )

          "(#{formatted_values})"
        end
      end
    end
  end
end
