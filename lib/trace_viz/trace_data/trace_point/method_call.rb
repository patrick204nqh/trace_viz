# frozen_string_literal: true

require_relative "base"
require "trace_viz/formatters/loggers/method_call_formatter"

module TraceViz
  module TraceData
    module TracePoint
      class MethodCall < Base
        def initialize(trace_point)
          super
          increment_depth
        end
      end
    end
  end
end
