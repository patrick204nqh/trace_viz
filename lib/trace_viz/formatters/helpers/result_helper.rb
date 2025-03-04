# frozen_string_literal: true

require "trace_viz/utils"

module TraceViz
  module Formatters
    module Helpers
      module ResultHelper
        def result_representation(trace_data)
          return unless config.result[:show]

          truncated_result = Utils::Format::ValueTruncator.truncate(
            trace_data.result.inspect,
            length: config.result[:truncate_value],
          )

          "#=> #{truncated_result}"
        end
      end
    end
  end
end
