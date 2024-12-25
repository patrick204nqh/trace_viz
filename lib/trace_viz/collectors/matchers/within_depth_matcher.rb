# frozen_string_literal: true

module TraceViz
  module Collectors
    module Matchers
      class WithinDepthMatcher
        def initialize
          @config = Context.for(:config).configuration
        end

        def matches?(depth)
          depth <= max_depth
        end

        private

        attr_reader :config

        def max_depth
          config.general[:max_display_depth]
        end
      end
    end
  end
end
