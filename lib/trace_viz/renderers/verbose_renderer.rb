# frozen_string_literal: true

require_relative "base_renderer"

module TraceViz
  module Renderers
    class VerboseRenderer < BaseRenderer
      def to_lines
        traverse_data(data)
      end

      private

      def data
        collector.collection
      end

      def traverse_data(data)
        data.map do |trace_data|
          NodeLine.new(trace_data, format_for(trace_data))
        end
      end

      def format_for(trace_data)
        context.fetch_formatter(trace_data.event).call(trace_data)
      end
    end
  end
end
