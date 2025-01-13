# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Formatters
    module Diagram
      module Sequence
        class MessageFormatter < BaseFormatter
          def format_call(to_trace)
            "Calling #{to_trace.klass}"
          end

          def format_return(from_trace, to_trace)
            "Returning to #{to_trace.klass}"
          end
        end
      end
    end
  end
end
