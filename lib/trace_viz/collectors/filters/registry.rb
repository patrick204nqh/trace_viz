# frozen_string_literal: true

require "trace_viz/collectors/filters/depth_filter"
require "trace_viz/collectors/filters/allow_classes_filter"
require "trace_viz/collectors/filters/exclude_internal_call_filter"
require "trace_viz/collectors/filters/exclude_gems_filter"
require "trace_viz/collectors/filters/exclude_rails_framework_filter"
require "trace_viz/collectors/filters/exclude_default_classes_filter"
require "trace_viz/collectors/filters/exclude_classes_filter"

module TraceViz
  module Collectors
    module Filters
      class Registry
        FILTERS = {
          depth: DepthFilter,
          allow_class: AllowClassesFilter,
          exclude_internal_call: ExcludeInternalCallFilter,
          exclude_gems: ExcludeGemsFilter,
          exclude_rails_framework: ExcludeRailsFrameworkFilter,
          exclude_default_classes: ExcludeDefaultClassesFilter,
          exclude_class: ExcludeClassesFilter,
        }.freeze

        class << self
          def build(filters)
            filters.each_with_object([]) do |filter, result|
              case filter
              when Symbol
                # Handle simple filters
                # (e.g., :depth, :exclude_internal_call)
                klass = fetch_filter_class(filter)
                result << klass.new
              when Hash
                # Handle complex filters with options
                # (e.g., { allow_class: { classes: [Example] } })
                filter.each do |filter_key, options|
                  klass = fetch_filter_class(filter_key)
                  result << klass.new(**options)
                end
              else
                raise ArgumentError, "Invalid filter format: #{filter.inspect}"
              end
            end
          end

          private

          def fetch_filter_class(filter_key)
            FILTERS.fetch(filter_key) do
              available_keys = FILTERS.keys.join(", ")
              raise ArgumentError, "Unknown filter: #{filter_key}. Available filters are: #{available_keys}"
            end
          end
        end
      end
    end
  end
end
