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

        @depth_manager = DepthManager.new
        @policy_evaluator = PolicyEvaluator.new(self.class.policies)
      end

      def collect
        raise NotImplementedError
      end

      def clear
        @collection = []
      end

      private

      attr_reader :depth_manager, :policy_evaluator

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
    end
  end
end
