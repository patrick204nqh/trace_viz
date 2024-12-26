# frozen_string_literal: true

module TraceViz
  module Context
    module Tracking
      class ActiveCalls
        def initialize
          @stack = []
        end

        def push(trace_data)
          @stack.push(trace_data)
        end

        def pop
          @stack.pop
        end

        def current
          @stack.last
        end

        def empty?
          @stack.empty?
        end

        def size
          @stack.size
        end

        def clear
          @stack.clear
        end
      end
    end
  end
end
