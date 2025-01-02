# frozen_string_literal: true

require_relative "method_call_formatter"
require_relative "method_return_formatter"

module TraceViz
  module Formatters
    module Log
      module Verbose
        class FormatterFactory
          FORMATTERS = {
            call: MethodCallFormatter.new,
            return: MethodReturnFormatter.new,
          }.freeze

          class << self
            def fetch_formatter(event)
              FORMATTERS.fetch(event) do
                raise ArgumentError, "Unsupported event: #{event}"
              end
            end
          end
        end
      end
    end
  end
end
