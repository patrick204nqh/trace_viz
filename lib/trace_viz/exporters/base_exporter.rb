# frozen_string_literal: true

module TraceViz
  module Exporters
    class BaseExporter
      def initialize(collection)
        @collection = collection
      end

      def export
        raise NotImplementedError
      end

      private

      attr_reader :collection
    end
  end
end
