# frozen_string_literal: true

require_relative "../base"

module TraceViz
  module TraceData
    module TracePoint
      class Base < TraceData::Base
        attr_reader :trace_point,
          :timestamp,
          :depth,
          :id,
          :event,
          :klass,
          :path,
          :line_number

        def initialize(trace_point)
          super()
          @trace_point = trace_point

          record_timestamp
          cache_basic_trace_data
        end

        def duration
          # TODO: Implement duration calculation
        end

        private

        def cache_basic_trace_data
          @id = trace_point.method_id
          @event = trace_point.event
          @klass = trace_point.defined_class
          @path = trace_point.path
          @line_number = trace_point.lineno
        end

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
