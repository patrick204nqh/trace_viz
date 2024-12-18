# frozen_string_literal: true

require "trace_viz/trace_data/trace_point/base"
require "trace_viz/formatters/trace_point/method_call_formatter"

module TraceViz
  module TraceData
    module TracePoint
      class MethodCall < Base
        def initialize(trace_point)
          super
          increment_depth
        end

        def log_trace
          formatted_call = Formatters::TracePoint::MethodCallFormatter.new(self).format
          logger.start(formatted_call)
        end

        private

        def increment_depth
          return @depth = 0 unless tracker&.depth

          @depth = tracker.depth.current || 0
          tracker.depth.increment
        end
      end
    end
  end
end
