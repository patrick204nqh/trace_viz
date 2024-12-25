# frozen_string_literal: true

require "trace_viz/trace_data/trace_point_builder"
require_relative "base_collector"
require_relative "matchers/trace_point_action_matcher"
require_relative "matchers/within_depth_matcher"
require_relative "depth_manager"

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

      def collectible(trace_point)
        within_depth? || match_action?(trace_point)
      end

      def build_trace(trace_point)
        TraceData::TracePointBuilder.build(trace_point)
      end

      def update_trace_depth(trace_data)
        depth_manager.align(trace_data)
      end

      def match_action?(trace_point)
        action_matcher.matches?(trace_point)
      end

      def within_depth?
        depth = tracker.current_depth

        within_depth_matcher.matches?(depth)
      end

      def depth_manager
        @depth_manager ||= DepthManager.new
      end
    end
  end
end
