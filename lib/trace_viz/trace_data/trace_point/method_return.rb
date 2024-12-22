# frozen_string_literal: true

require_relative "base"

module TraceViz
  module TraceData
    module TracePoint
      class MethodReturn < Base
        attr_reader :result

        def initialize(trace_point)
          super(trace_point)

          cache_result
          decrement_depth
        end

        private

        def cache_result
          @result = @trace_point.return_value
        end
      end
    end
  end
end
