# frozen_string_literal: true

require_relative "base"

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
