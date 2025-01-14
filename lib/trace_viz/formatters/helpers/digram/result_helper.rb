# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module Diagram
        module ResultHelper
          def result_representation(trace_data)
            return unless config.result[:show]

            result = truncate_result(trace_data.result)
            result = sinitize_result(result)
            result
          end

          private

          def truncate_result(input)
            Utils::FormatUtils.truncate_value(
              input,
              config.result[:truncate_length],
            )
          end

          def sinitize_result(input)
            input.to_s
              .gsub("#", "")
              .strip
          end
        end
      end
    end
  end
end
