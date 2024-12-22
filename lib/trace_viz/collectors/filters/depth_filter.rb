# frozen_string_literal: true

require_relative "base_filter"

module TraceViz
  module Collectors
    module Filters
      class DepthFilter < BaseFilter
        def initialize
          super()
          @max_depth = config.max_display_depth
        end

        def apply?(trace_data)
          within_depth?(trace_data.depth)
        end

        private

        def within_depth?(depth)
          depth <= @max_depth
        end
      end
    end
  end
end
