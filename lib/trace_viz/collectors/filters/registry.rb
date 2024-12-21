# frozen_string_literal: true

require "trace_viz/collectors/filters/depth_filter"
require "trace_viz/collectors/filters/exclude_internal_call_filter"
require "trace_viz/collectors/filters/exclude_rails_framework_filter"

module TraceViz
  module Collectors
    module Filters
      class Registry
        class << self
          def available_filters
            {
              depth: DepthFilter,
              exclude_internal_call: ExcludeInternalCallFilter,
              exclude_rails_framework: ExcludeRailsFrameworkFilter,
            }
          end

          def build(filters)
            filters.map do |filter_key|
              klass = available_filters[filter_key]
              raise ArgumentError, "Unknown filter: #{filter_key}" unless klass

              klass.new
            end
          end
        end
      end
    end
  end
end
