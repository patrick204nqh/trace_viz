# frozen_string_literal: true

require_relative "base_evaluator"

module TraceViz
  module Collectors
    module Evaluators
      class HiddenEvaluator < BaseEvaluator
        def pass?(trace_data)
          !allowed_events.include?(trace_data.event)
        end

        private

        def allowed_events
          config.execution[:show_trace_events]
        end
      end
    end
  end
end
