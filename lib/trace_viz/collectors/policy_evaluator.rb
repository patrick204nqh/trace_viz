# frozen_string_literal: true

module TraceViz
  module Collectors
    class PolicyEvaluator
      def initialize(policies = [])
        @policies = policies
      end

      def eligible_for_collection?(trace_data)
        @policies.all? { |policy| policy.applicable?(trace_data) }
      end
    end
  end
end
