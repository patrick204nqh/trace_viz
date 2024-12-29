# frozen_string_literal: true

require_relative "base_step"

module TraceViz
  module Collectors
    module Steps
      class AssignDepthStep < BaseStep
        def call(trace_data)
          assign_depth(trace_data)
        rescue StandardError => e
          logger.error("Depth assignment failed for trace_data ID: #{trace_data.id} - #{e.message}")
          nil
        end

        private

        def assign_depth(trace_data)
          case trace_data.event
          when :call
            handle_call(trace_data)
          when :return
            handle_return(trace_data)
          else
            logger.warn("Unknown event type: #{trace_data.event}")
          end

          trace_data
        end

        def handle_call(trace_data)
          trace_data.depth = current_depth
          active_call_stack.push(trace_data)
        end

        def handle_return(trace_data)
          active_call_stack.pop if call_matches?(trace_data)

          trace_data.depth = current_depth
        end

        def call_matches?(trace_data)
          trace_data.action_id == current_call&.action_id
        end
      end
    end
  end
end
