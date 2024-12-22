# frozen_string_literal: true

require_relative "base"

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
