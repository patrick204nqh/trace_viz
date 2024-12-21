# frozen_string_literal: true

require "trace_viz/collectors/filters/depth_filter"
require "trace_viz/collectors/filters/exclude_internal_call_filter"
require "trace_viz/collectors/filters/exclude_rails_framework_filter"
require "trace_viz/collectors/filters/allow_class_filter"
require "trace_viz/collectors/filters/exclude_class_filter"

module TraceViz
  module Collectors
    module Filters
      class Registry
        FILTERS = {
          depth: DepthFilter,
          exclude_internal_call: ExcludeInternalCallFilter,
          exclude_rails_framework: ExcludeRailsFrameworkFilter,
          allow_class: AllowClassFilter,
          exclude_class: ExcludeClassFilter,
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
