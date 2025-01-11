# frozen_string_literal: true

require_relative "base_exporter"

module TraceViz
  module Exporters
    class TextExporter < BaseExporter
      def content
        data.join("\n")
      end

      def data
        process_lines(renderer.to_lines) { |line| line[:line] }
      end
    end
  end
end
