# frozen_string_literal: true

require_relative "base_step"

module TraceViz
  module Collectors
    module Steps
      class AssignDepthForCallStep < BaseStep
        def call(trace_data)
          assign_depth(trace_data) if valid?(trace_data)
          trace_data
        rescue StandardError => e
          logger.error("Depth assignment failed for trace_data ID: #{trace_data.id} - #{e.message}")
          nil
        end

        private

        def valid?(trace_data)
          trace_data.event == :call
        end

        def assign_depth(trace_data)
          trace_data.assign_depth(current_depth)
          active_call_stack.push(trace_data)
        end
      end
    end
  end
end
