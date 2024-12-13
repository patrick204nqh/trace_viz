# frozen_string_literal: true

require "trace_viz/context/base_context"
require "trace_viz/context/tracking/depth"

module TraceViz
  module Context
    class TrackingContext < BaseContext
      attr_reader :depth

      def initialize(**options)
        super

        @depth = Tracking::Depth.new
      end
    end
  end
end
