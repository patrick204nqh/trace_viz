# frozen_string_literal: true

require_relative "base"
require "trace_viz/formatters/loggers/method_return_formatter"

module TraceViz
  module TraceData
    module TracePoint
      class MethodReturn < Base
        def initialize(trace_point)
          super
          decrement_depth
        end
      end
    end
  end
end
