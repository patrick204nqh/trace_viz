# frozen_string_literal: true

module TraceViz
  module DiagramBuilders
    module Extractors
      class BaseExtractor
        attr_reader :collector

        def initialize(collector)
          @collector = collector
        end

        def extract
          raise NotImplementedError
        end
      end
    end
  end
end
