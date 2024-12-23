# frozen_string_literal: true

require_relative "policy_evaluator"
require_relative "policies/filter_policy"
require_relative "policies/event_policy"

module TraceViz
  module Collectors
    class BaseCollector
      attr_reader :collection

      def initialize
        @collection = []

        @policy_evaluator = PolicyEvaluator.new(
          [
            Policies::FilterPolicy.new,
            Policies::EventPolicy.new,
          ],
        )
      end

      def collect
        raise NotImplementedError
      end

      def clear
        @collection = []
      end

      private

      attr_reader :policy_evaluator

      def should_collect?(trace_data)
        policy_evaluator.eligible_for_collection?(trace_data)
      end
    end
  end
end
