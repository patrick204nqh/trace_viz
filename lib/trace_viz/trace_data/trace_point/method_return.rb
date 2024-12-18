# frozen_string_literal: true

require "trace_viz/trace_data/trace_point/base"
require "trace_viz/formatters/trace_point/method_return_formatter"

module TraceViz
  module TraceData
    module TracePoint
      class MethodReturn < Base
        def initialize(trace_point)
          super
          decrement_depth
        end

        def log_trace
          formatted_return = Formatters::TracePoint::MethodReturnFormatter.new(self).format
          logger.finish(formatted_return)
        end

        private

        def decrement_depth
          return 0 unless tracker&.depth

          @depth = tracker.depth.decrement
        end
      end
    end
  end
end
