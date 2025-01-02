# frozen_string_literal: true

require "trace_viz/utils/format_utils"

module TraceViz
  module Formatters
    module Helpers
      module ResultHelper
        def result_representation(trace_data)
          return unless config.result[:show]

          truncated_result = Utils::FormatUtils.truncate_value(
            trace_data.result.inspect,
            config.result[:truncate_length],
          )
          "#=> #{truncated_result}"
        end
      end
    end
  end
end
