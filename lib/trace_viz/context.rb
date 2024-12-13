# frozen_string_literal: true

require "trace_viz/context/tracking"

module TraceViz
  class Context
    attr_reader :tracking

    def initialize
      @tracking = Tracking.new
    end
  end
end
