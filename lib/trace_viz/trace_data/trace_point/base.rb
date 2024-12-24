# frozen_string_literal: true

require_relative "../base"

module TraceViz
  module TraceData
    module TracePoint
      class Base < TraceData::Base
        attr_reader :trace_point,
          :id,
          :event,
          :klass,
          :action,
          :path,
          :line_number

        def initialize(trace_point)
          super()
          @trace_point = trace_point

          populate_trace_attributes
        end

        def duration
          # TODO: Implement duration calculation
        end

        private

        def populate_trace_attributes
          @id = trace_point.object_id
          @event = trace_point.event
          @klass = trace_point.defined_class
          @action = trace_point.method_id
          @path = trace_point.path
          @line_number = trace_point.lineno
        end
      end
    end
  end
end
