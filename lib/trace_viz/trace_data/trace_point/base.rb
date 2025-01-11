# frozen_string_literal: true

require "trace_viz/traits"
require_relative "../node"

module TraceViz
  module TraceData
    module TracePoint
      class Base < TraceData::Node
        include Traits::Identifiable

        attr_reader :trace_point,
          :memory_id,
          :event,
          :klass,
          :action,
          :path,
          :line_number

        def initialize(trace_point)
          super()

          @trace_point = trace_point
          populate_attributes
          assign_memory_id
          assign_ids
        end

        def key
          event
        end

        def duration
          0
        end

        def to_h
          super.merge(
            {
              id: id,
              action_id: action_id,
              memory_id: memory_id,
            },
          )
        end

        private

        def populate_attributes
          @event = trace_point.event
          @klass = trace_point.defined_class
          @action = trace_point.callee_id
          @path = trace_point.path
          @line_number = trace_point.lineno
        end

        def assign_memory_id
          @memory_id = trace_point.self.object_id
        end
      end
    end
  end
end
