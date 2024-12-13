# frozen_string_literal: true

module TraceViz
  module Adapters
    module TracePoint
      class EventHandler
        def initialize(trace_data)
          @trace_data = trace_data
        end

        def handle
          case trace_data.event
          when :call
            handle_call
          when :return
            handle_return
          else
            raise "Unknown event type #{trace_data.event}"
          end
        end

        private

        attr_reader :trace_data

        def handle_call
          trace_data.log_trace
        end

        def handle_return
          trace_data.log_trace
        end
      end
    end
  end
end
