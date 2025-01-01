# frozen_string_literal: true

module TraceViz
  module Exporters
    module Transformers
      class BaseTransformer
        def initialize(collector)
          @collector = collector
        end

        def transform
          raise NotImplementedError
        end

        private

        attr_reader :collector

        def collection
          collector.collection
        end

        def hierarchy
          collector.hierarchy
        end
      end
    end
  end
end
