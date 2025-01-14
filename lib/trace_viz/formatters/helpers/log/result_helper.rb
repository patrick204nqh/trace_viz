# frozen_string_literal: true

require "trace_viz/utils"

module TraceViz
  module Formatters
    module Helpers
      module Log
        module ResultHelper
          def format_result(trace_data, config)
            return unless config.result[:show]

            truncated_result = Utils::Format::ValueTruncator.truncate(
              trace_data.result.inspect,
              length: config.result[:truncate_value],
            )

            prefix = colorize_for("#=>", :trace_result_prefix)
            result = colorize_for(truncated_result, :trace_result_value)

            [prefix, result].join(" ")
          end
        end
      end
    end
  end
end
