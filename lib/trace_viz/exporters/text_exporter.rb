# frozen_string_literal: true

require_relative "base_exporter"
require_relative "transformers/text_transformer"

module TraceViz
  module Exporters
    class TextExporter < BaseExporter
      private

      def transform_collector_data(collector)
        transformer = Transformers::TextTransformer.new(collector)
        transformer.transform
      end

      def content
        data.join("\n")
      end
    end
  end
end
