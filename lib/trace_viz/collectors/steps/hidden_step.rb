# frozen_string_literal: true

require_relative "base_step"

module TraceViz
  module Collectors
    module Steps
      class HiddenStep < BaseStep
        def call(trace_data)
          trace_data unless pass?(trace_data)
        end

        private

        def pass?(trace_data)
          !allowed_events.include?(trace_data.event)
        end

        def allowed_events
          config.execution[:show_trace_events]
        end
      end
    end
  end
end
