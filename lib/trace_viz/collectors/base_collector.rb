# frozen_string_literal: true

require_relative "depth_manager"
require_relative "policy_evaluator"
require_relative "policies/filter_policy"
require_relative "policies/event_policy"

module TraceViz
  module Collectors
    class BaseCollector
      attr_reader :collection

      def initialize
        @collection = []
      end

      def collect
        raise NotImplementedError
      end

      def clear
        @collection = []
      end

      private

      class << self
        def policies
          [
            Policies::FilterPolicy.new,
            Policies::EventPolicy.new,
          ]
        end
      end

      def log_trace(trace_data)
        Loggers::TraceLogger.log(trace_data)
      end

      def store_trace(trace_data)
        @collection << trace_data
      end

      def depth_manager
        @depth_manager ||= DepthManager.new
      end

      def policy_evaluator
        @policy_evaluator ||= PolicyEvaluator.new(self.class.policies)
      end
    end
  end
end
