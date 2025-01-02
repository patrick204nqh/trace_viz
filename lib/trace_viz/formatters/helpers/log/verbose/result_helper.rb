# frozen_string_literal: true

require "trace_viz/utils/format_utils"

module TraceViz
  module Formatters
    module Helpers
      module Log
        module Verbose
          module ResultHelper
            def format_result(trace_data, config)
              return unless config.result[:show]

              truncated_result = Utils::FormatUtils.truncate_value(
                trace_data.result.inspect,
                config.result[:truncate_length],
              )

              prefix = colorize("#=>", :trace_result_prefix)
              result = colorize(truncated_result, :trace_result_value)

              [prefix, result].join(" ")
            end
          end
        end
      end
    end
  end
end
