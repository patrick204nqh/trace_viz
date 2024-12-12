# frozen_string_literal: true

require "singleton"
require "trace_viz/context/depth"

module TraceViz
  class Context
    attr_reader :depth

    def initialize
      @depth = Depth.new
    end
  end
end
