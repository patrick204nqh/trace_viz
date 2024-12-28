# frozen_string_literal: true

require "trace_viz/utils/format_utils"

module TraceViz
  module Loggers
    module TraceFormatters
      module Helpers
        module ResultHelper
          def format_result(trace_data, config)
            return unless config.result[:show]

            truncated_result = Utils::FormatUtils.truncate_value(
              trace_data.result.inspect,
              config.result[:truncate_length],
            )

            prefix = colorize("#=>", :dim, :italic, :light_blue)
            result = colorize(truncated_result, :dim, :light_gray)

            [prefix, result].join(" ")
          end
        end
      end
    end
  end
end
