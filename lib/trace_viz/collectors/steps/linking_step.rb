# frozen_string_literal: true

require "trace_viz/context"
require_relative "base_step"

module TraceViz
  module Collectors
    module Steps
      class LinkingStep < BaseStep
        def call(trace_data)
          valid?(trace_data) ? linking_trace(trace_data) : trace_data
        rescue StandardError => e
          logger.error("Linking failed for trace_data ID: #{trace_data.id} - #{e.message}")
          nil
        end

        private

        def valid?(trace_data)
          return false unless current_call

          [
            trace_data.event == :return,
            current_call.event == :call,
            trace_data.action_id == current_call.action_id,
          ].all?
        end

        def linking_trace(trace_data)
          trace_data.link(current_call)
          trace_data
        end
      end
    end
  end
end
