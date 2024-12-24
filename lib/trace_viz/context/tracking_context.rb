# frozen_string_literal: true

require "trace_viz/context/base_context"
require "trace_viz/context/tracking/depth"
require "trace_viz/context/tracking/active_calls"

module TraceViz
  module Context
    class TrackingContext < BaseContext
      attr_reader :depth, :active_calls

      def initialize(**options)
        super

        @depth = Tracking::Depth.new
        @active_calls = Tracking::ActiveCalls.new
      end
    end
  end
end
