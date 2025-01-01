# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require_relative "base_collector"
require_relative "matchers/trace_point_action_matcher"
require_relative "matchers/within_depth_matcher"

module TraceViz
  module Collectors
    class TracePointCollector < BaseCollector
      def initialize
        super()

        @action_matcher = Matchers::TracePointActionMatcher.new
        @within_depth_matcher = Matchers::WithinDepthMatcher.new
      end

      private

      attr_reader :action_matcher, :within_depth_matcher

      def can_collect?(trace_point)
        within_depth? || match_action?(trace_point)
      end

      def build_trace(trace_point)
        TraceData::TracePointBuilder.build(trace_point)
      end

      def match_action?(trace_point)
        action_matcher.matches?(trace_point)
      end

      def within_depth?
        depth = tracker.current_depth

        within_depth_matcher.matches?(depth)
      end
    end
  end
end
