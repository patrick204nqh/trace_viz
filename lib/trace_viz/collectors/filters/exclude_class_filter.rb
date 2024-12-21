# frozen_string_literal: true

require "trace_viz/collectors/filters/base_filter"

module TraceViz
  module Collectors
    module Filters
      class ExcludeClassFilter < BaseFilter
        def initialize(**options)
          super()
          @excluded_classes = options[:classes].map(&:to_s).freeze
        end

        def apply?(trace_data)
          !exclude_class?(trace_data.klass)
        end

        private

        attr_reader :excluded_classes

        def exclude_class?(klass)
          excluded_classes.include?(klass.to_s)
        end
      end
    end
  end
end
