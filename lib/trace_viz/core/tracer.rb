# frozen_string_literal: true

require "trace_viz/logger"
require "trace_viz/context"
require "trace_viz/adapters/trace_point_adapter"

module TraceViz
  module Core
    class Tracer
      def trace(**options, &block)
        Context::Manager.enter_multiple_contexts(
          config: options,
          tracking: {},
        )

        begin
          adapter = Adapters::TracePointAdapter.new
          adapter.trace(&block)
        ensure
          Context::Manager.exit_multiple_contexts(:config, :tracking)
        end
      end
    end
  end
end
