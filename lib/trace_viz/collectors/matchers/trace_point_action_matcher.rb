# frozen_string_literal: true

require "trace_viz/trace_data/id_generator"
require "trace_viz/helpers/tracking_helper"
require_relative "base_matcher"

module TraceViz
  module Collectors
    module Matchers
      class TracePointActionMatcher < BaseMatcher
        include Helpers::TrackingHelper

        def matches?(trace_point)
          current_action_id == build_action_id(trace_point)
        end

        private

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

        private :tracker, :active_call_stack, :current_call, :current_depth
      end
    end
  end
end
