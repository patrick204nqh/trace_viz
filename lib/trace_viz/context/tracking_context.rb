# frozen_string_literal: true

require "trace_viz/context/base_context"
require "trace_viz/context/tracking/depth"
require "trace_viz/context/tracking/active_calls"

module TraceViz
  module Context
    class TrackingContext < BaseContext
      attr_reader :active_calls

      def initialize(**options)
        super

        @active_calls = Tracking::ActiveCalls.new
      end

      def current_call
        active_calls.current
      end

      def current_depth
        active_calls.size
      end
    end
  end
end
