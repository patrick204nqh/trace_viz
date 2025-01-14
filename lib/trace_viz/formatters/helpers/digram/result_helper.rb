# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module Diagram
        module ResultHelper
          def result_representation(trace_data)
            return unless config.result[:show]

            result = truncate_structure(trace_data.result)
            result = sinitize_result(result)
            result
          end

          private

          def truncate_structure(input)
            Utils::FormatUtils.truncate_value(
              input,
              config.result[:truncate_value],
              hash_length: config.result[:truncate_length],
            )
          end

          def sinitize_result(input)
            input.to_s
              # .gsub('"', "")
              # .gsub("'", "")
              .gsub("#", "")
              .strip
          end
        end
      end
    end
  end
end
