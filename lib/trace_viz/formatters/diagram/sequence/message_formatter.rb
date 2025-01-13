# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Diagram
      module Sequence
        class MessageFormatter < BaseFormatter
          def format_call
            "Calling"
          end

          def format_return
            "Returning"
          end
        end
      end
    end
  end
end
