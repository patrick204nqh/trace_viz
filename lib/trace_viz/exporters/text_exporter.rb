# frozen_string_literal: true

require_relative "base_exporter"

module TraceViz
  module Exporters
    class TextExporter < BaseExporter
      private

      def content
        data.join("\n")
      end
    end
  end
end
