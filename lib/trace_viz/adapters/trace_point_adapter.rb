# frozen_string_literal: true

require "trace_viz/adapters/base_adapter"
require "trace_viz/trace_data/trace_point_builder"

module TraceViz
  module Adapters
    class TracePointAdapter < BaseAdapter
      def trace(&block)
        ::TracePoint.new(:call, :return) do |tp|
          trace_data = TraceData::TracePointBuilder.build(tp)

          next if trace_data.internal_call?
          next if trace_data.exceeded_max_depth?

          trace_data.log_trace
        end.enable(&block)
      end
    end
  end
end
