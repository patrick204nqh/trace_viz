# frozen_string_literal: true

require_relative "base_step"

module TraceViz
  module Collectors
    module Steps
      class BuildHierarchyStep < BaseStep
        def call(trace_data)
          link_to_parent(trace_data) if valid?(trace_data)

          trace_data
        rescue StandardError => e
          logger.error("Hierarchy building failed for trace_data ID: #{trace_data.id} - #{e.message}")
          nil
        end

        private

        def valid?(trace_data)
          trace_data.event == :call
        end

        def link_to_parent(trace_data)
          return unless current_call

          current_call.add_child(trace_data)
        end
      end
    end
  end
end
