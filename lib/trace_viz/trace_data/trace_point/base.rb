# frozen_string_literal: true

require_relative "../base"

module TraceViz
  module TraceData
    module TracePoint
      class Base < TraceData::Base
        attr_reader :trace_point, :timestamp, :depth

        def initialize(trace_point)
          super()
          @trace_point = trace_point

          record_timestamp
        end

        def id
          trace_point.method_id
        end

        def event
          trace_point.event
        end

        def path
          trace_point.path
        end

        def line_number
          trace_point.lineno
        end

        def klass
          trace_point.defined_class
        end

        def params
          trace_point.binding.local_variables
        end

        def result
          trace_point.return_value
        end

        def duration
          # TODO: Implement duration calculation
        end

        private

        def record_timestamp
          @timestamp = Time.now
        end

        def increment_depth
          return @depth = 0 unless tracker&.depth

          @depth = tracker.depth.current || 0
          tracker.depth.increment
        end

        def decrement_depth
          return 0 unless tracker&.depth

          @depth = tracker.depth.decrement
        end
      end
    end
  end
end
