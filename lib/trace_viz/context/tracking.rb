# frozen_string_literal: true

require "trace_viz/context/tracking/depth"

module TraceViz
  class Context
    class Tracking
      attr_reader :depth

      def initialize
        @depth = Depth.new
      end
    end
  end
end
