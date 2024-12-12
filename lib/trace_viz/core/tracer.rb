# frozen_string_literal: true

require "trace_viz/logger"
require "trace_viz/context"
require "trace_viz/adapters/trace_point_adapter"

module TraceViz
  module Core
    class Tracer
      def trace(&block)
        adapter = Adapters::TracePointAdapter.new
        adapter.trace(&block)
      end
    end
  end
end
