# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module Collectors
    module Evaluators
      class BaseEvaluator
        def initialize
          @config = Context.for(:config).configuration
        end

        def pass?(trace_data)
          raise NotImplementedError
        end

        private

        attr_reader :config
      end
    end
  end
end