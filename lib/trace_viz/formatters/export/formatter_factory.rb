# frozen_string_literal: true

require_relative "method_call_formatter"
require_relative "method_return_formatter"
require_relative "summary_group_formatter"

module TraceViz
  module Formatters
    module Export
      class FormatterFactory
        FORMATTERS = {
          call: MethodCallFormatter.new,
          return: MethodReturnFormatter.new,
          summary_group: SummaryGroupFormatter.new,
        }.freeze

        class << self
          def fetch_formatter(key)
            FORMATTERS.fetch(key) do
              raise ArgumentError, "Unsupported factory key: #{key}"
            end
          end
        end
      end
    end
  end
end
