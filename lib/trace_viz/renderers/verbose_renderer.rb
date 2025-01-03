# frozen_string_literal: true

require_relative "base_renderer"
require "trace_viz/formatters/log/formatter_factory"

module TraceViz
  module Renderers
    class VerboseRenderer < BaseRenderer
      def to_lines
        traverse_data(data)
      end

      private

      def traverse_data(data)
        data.map do |trace_data|
          {
            line: format_for(trace_data),
            trace_data: trace_data,
          }
        end
      end

      def format_for(trace_data)
        context.fetch_formatter(trace_data.event).call(trace_data)
      end
    end
  end
end
