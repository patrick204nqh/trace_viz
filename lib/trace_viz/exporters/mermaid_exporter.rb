# frozen_string_literal: true

module TraceViz
  module Exporters
    class MermaidExporter < BaseExporter
      private

      def renderer_mode
        :sequence_diagram
      end

      def file_extension
        ".mmd"
      end
    end
  end
end
