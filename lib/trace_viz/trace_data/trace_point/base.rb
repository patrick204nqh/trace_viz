# frozen_string_literal: true

require "trace_viz/trace_data/base"

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

        def exceeded_max_depth?
          return false unless config.max_display_depth

          depth > config.max_display_depth
        end

        def duration
          # TODO: Implement duration calculation
        end

        private

        def record_timestamp
          @timestamp = Time.now
        end
      end
    end
  end
end
