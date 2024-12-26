# frozen_string_literal: true

require_relative "../base"

module TraceViz
  module TraceData
    module TracePoint
      class Base < TraceData::Base
        attr_reader :trace_point,
          :id,
          :action_id,
          :event,
          :klass,
          :action,
          :path,
          :line_number

        def initialize(trace_point)
          super()

          @trace_point = trace_point

          populate_trace_attributes
          assign_ids
        end

        def duration
          # TODO: Implement duration calculation
        end

        private

        def populate_trace_attributes
          @event = trace_point.event
          @klass = trace_point.defined_class
          @action = trace_point.callee_id
          @path = trace_point.path
          @line_number = trace_point.lineno
        end

        def assign_ids
          @id = generate_unique_id
          @action_id = generate_action_id
        end

        def memory_id
          trace_point.self.object_id
        end

        def generate_unique_id
          [
            memory_id,
            action,
            path,
            line_number,
          ].join("_")
        end

        def generate_action_id
          [
            memory_id,
            action,
          ].join("_")
        end
      end
    end
  end
end
