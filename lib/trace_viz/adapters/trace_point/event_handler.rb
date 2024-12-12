# frozen_string_literal: true

require "trace_viz/context_manager"

module TraceViz
  module Adapters
    module TracePoint
      class EventHandler
        def initialize(trace_data)
          @trace_data = trace_data
        end

        def handle
          case @trace_data.event
          when :call
            handle_call
          when :return
            handle_return
          else
            raise "Unknown event type #{@trace_data.event}"
          end
        end

        private

        def handle_call
          @trace_data.log_trace
        end

        def handle_return
          @trace_data.log_trace
        end
      end
    end
  end
end
