# frozen_string_literal: true

module TraceViz
  module Adapters
    module TracePoint
      class DepthManager
        def initialize
          @context = ContextManager.get_context(:tracking)
        end

        def assign_depth(trace_data)
          context_depth = context_tracking&.depth
          return 0 unless context_depth

          case trace_data.event
          when :call
            current_depth = context_depth.current || 0
            context_depth.increment
            current_depth
          when :return
            context_depth.decrement
          else
            0 # Disables depth tracking for other events
          end
        end

        private

        attr_reader :context

        def context_tracking
          context&.tracking
        end
      end
    end
  end
end
