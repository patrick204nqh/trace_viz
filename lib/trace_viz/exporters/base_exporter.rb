# frozen_string_literal: true

require_relative "transformers/text_transformer"

module TraceViz
  module Exporters
    class BaseExporter
      def initialize(collector)
        @data = transform_collector_data(collector)
      end

      def export
        raise NotImplementedError
      end

      private

      attr_reader :data

      def transform_collector_data(collector)
        transformer = Transformers::TextTransformer.new(collector)
        transformer.transform
      end
    end
  end
end
