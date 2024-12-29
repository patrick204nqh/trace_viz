# frozen_string_literal: true

module TraceViz
  module Collectors
    class TracePipeline
      def initialize
        @steps = []
      end

      def add_step(step)
        @steps << step
      end

      def process(trace_data)
        @steps.each do |step|
          trace_data = step.call(trace_data)
          return nil unless trace_data
        end
        trace_data
      rescue StandardError => e
        TraceViz.logger.error("Pipeline processing failed for trace_data ID: #{trace_data.id} - #{e.message}")
        nil
      end
    end
  end
end
