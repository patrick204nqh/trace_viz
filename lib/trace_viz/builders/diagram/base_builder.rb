# frozen_string_literal: true

module TraceViz
  module Builders
    module Diagram
      class BaseBuilder
        def initialize(collector)
          @collector = collector
        end

        private

        attr_reader :collector
      end
    end
  end
end
