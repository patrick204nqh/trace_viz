# frozen_string_literal: true

require_relative "base_renderer"
require "trace_viz/formatters/log/verbose/formatter_factory"

module TraceViz
  module Renderers
    class VerboseRenderer < BaseRenderer
      def render
        data.map do |trace_data|
          format_for(trace_data)
        end.join("\n")
      end

      def to_lines
        data.map do |trace_data|
          {
            line: format_for(trace_data),
            trace_data: trace_data,
          }
        end
      end

      private

      def format_for(trace_data)
        formatter = fetch_formatter(trace_data)
        formatter.call(trace_data)
      end

      def fetch_formatter(trace_data)
        Formatters::Log::Verbose::FormatterFactory.fetch_formatter(trace_data.event)
      end
    end
  end
end
