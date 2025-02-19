# frozen_string_literal: true

require_relative "text_exporter"
require_relative "mermaid_exporter"

module TraceViz
  module Exporters
    class Registry
      EXPORTS = {
        txt: TextExporter,
        mermaid: MermaidExporter,
      }

      class << self
        def build(format, *options)
          raise ArgumentError unless supported_formats.include?(format)

          EXPORTS[format].new(*options)
        end

        def supported_formats
          EXPORTS.keys
        end
      end
    end
  end
end
