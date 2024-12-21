# frozen_string_literal: true

require "trace_viz/adapters/base_adapter"
require "trace_viz/collectors/trace_point_collector"

module TraceViz
  module Adapters
    class TracePointAdapter < BaseAdapter
      def initialize
        super()

        @collector = Collectors::TracePointCollector.new
      end

      def trace(&block)
        ::TracePoint.new(:call, :return) do |tp|
          @collector.collect(tp)
        end.enable(&block)
      end
    end
  end
end
