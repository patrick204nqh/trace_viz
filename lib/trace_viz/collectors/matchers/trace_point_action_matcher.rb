# frozen_string_literal: true

require "trace_viz/trace_data/id_generator"

module TraceViz
  module Collectors
    module Matchers
      class TracePointActionMatcher
        def initialize
          @tracker = Context.for(:tracking)
        end

        def matches?(trace_point)
          current_action_id == build_action_id(trace_point)
        end

        private

        attr_reader :tracker

        def current_action
          tracker.active_calls.current
        end

        def current_action_id
          current_action&.action_id
        end

        def build_action_id(trace_point)
          TraceData::IDGenerator.generate_action_id(
            memory_id: trace_point.self.object_id,
            action: trace_point.callee_id,
          )
        end
      end
    end
  end
end
