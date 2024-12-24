# frozen_string_literal: true

require "trace_viz/defaults"
require "trace_viz/logger"
require "trace_viz/context"
require "trace_viz/configuration"
require "trace_viz/adapters/trace_point_adapter"

module TraceViz
  module Core
    class Tracer
      def trace(**options, &block)
        Context::Manager.with_contexts(config: options, tracking: {}) do
          adapter = Adapters::TracePointAdapter.new
          adapter.trace(&block)
        end
      end
    end
  end
end
