# frozen_string_literal: true

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
          [
            trace_point.self.object_id,
            trace_point.callee_id,
          ].join("_")
        end
      end
    end
  end
end
