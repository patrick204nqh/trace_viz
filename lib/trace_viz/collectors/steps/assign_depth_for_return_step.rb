# frozen_string_literal: true

require_relative "base_step"

module TraceViz
  module Collectors
    module Steps
      class AssignDepthForReturnStep < BaseStep
        def call(trace_data)
          assign_depth(trace_data) if valid?(trace_data)
          trace_data
        rescue StandardError => e
          logger.error("Depth assignment failed for trace_data ID: #{trace_data.id} - #{e.message}")
          nil
        end

        private

        def valid?(trace_data)
          trace_data.event == :return
        end

        def call_matches?(trace_data)
          trace_data.action_id == current_call&.action_id
        end

        def assign_depth(trace_data)
          if call_matches?(trace_data)
            active_call_stack.pop
          else
            logger.warn("Unmatched return event for trace_data ID #{trace_data.id}")
          end

          trace_data.assign_depth(current_depth)
        end
      end
    end
  end
end
