# frozen_string_literal: true

require "trace_viz/logger"
require "trace_viz/adapters/base_adapter"
require "trace_viz/adapters/trace_point/trace_data"
require "trace_viz/adapters/trace_point/event_handler"

module TraceViz
  module Adapters
    class TracePointAdapter < BaseAdapter
      def trace(&block)
        ContextManager.enter_context

        ::TracePoint.new(:call, :return) do |tp|
          trace_data = TracePoint::TraceData.new(tp)

          next if trace_data.internal_call?
          next if trace_data.exceeded_max_depth?

          TracePoint::EventHandler.new(trace_data).handle
        end.enable(&block)

        ContextManager.exit_context
      end
    end
  end
end
