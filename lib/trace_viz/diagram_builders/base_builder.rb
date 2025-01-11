# frozen_string_literal: true

module TraceViz
  module DiagramBuilders
    class BaseBuilder
      attr_reader :collector

      def initialize(collector)
        @collector = collector
      end

      def build
        raise NotImplementedError
      end
    end
  end
end
