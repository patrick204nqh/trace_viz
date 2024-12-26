# frozen_string_literal: true

require_relative "base_filter"

module TraceViz
  module Collectors
    module Filters
      class IncludeClassesFilter < BaseFilter
        def initialize(**options)
          super()
          @allowed_classes = options[:classes].map(&:to_s).freeze
        end

        def apply?(trace_data)
          include_class?(trace_data.klass)
        end

        private

        attr_reader :allowed_classes

        def include_class?(klass)
          allowed_classes.include?(klass.to_s)
        end
      end
    end
  end
end
