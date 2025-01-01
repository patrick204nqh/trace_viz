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
          assign_ids
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
              event: event,
              depth: depth,
              klass: klass,
              action: action,
              path: path,
              line_number: line_number,
            },
          )
        end

        private

        def populate_attributes
          @memory_id = trace_point.self.object_id
          @event = trace_point.event
          @klass = trace_point.defined_class
          @action = trace_point.callee_id
          @path = trace_point.path
          @line_number = trace_point.lineno
        end
      end
    end
  end
end
