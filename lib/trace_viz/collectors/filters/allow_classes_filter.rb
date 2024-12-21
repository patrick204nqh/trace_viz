# frozen_string_literal: true

require "trace_viz/collectors/filters/base_filter"

module TraceViz
  module Collectors
    module Filters
      class AllowClassesFilter < BaseFilter
        def initialize(**options)
          super()
          @allowed_classes = options[:classes].map(&:to_s).freeze
        end

        def apply?(trace_data)
          allow_class?(trace_data.klass)
        end

        private

        attr_reader :allowed_classes

        def allow_class?(klass)
          allowed_classes.include?(klass.to_s)
        end
      end
    end
  end
end
