# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module Collectors
    module Filters
      class BaseFilter
        def initialize
          @config = Context.for(:config).configuration
        end

        def apply?(trace_data)
          raise NotImplementedError
        end

        private

        attr_reader :config
      end
    end
  end
end
