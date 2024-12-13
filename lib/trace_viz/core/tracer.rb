# frozen_string_literal: true

require "trace_viz/logger"
require "trace_viz/context_manager"
require "trace_viz/adapters/trace_point_adapter"

module TraceViz
  module Core
    class Tracer
      def trace(&block)
        ContextManager.enter_context(:tracking)

        adapter = Adapters::TracePointAdapter.new
        adapter.trace(&block)

        ContextManager.remove_context(:tracking)
      end
    end
  end
end
