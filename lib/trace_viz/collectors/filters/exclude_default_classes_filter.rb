# frozen_string_literal: true

require "set"

module TraceViz
  module Collectors
    module Filters
      class ExcludeDefaultClassesFilter < BaseFilter
        RUBY_CORE_CLASSES = Set.new([
          Object,
          String,
          Array,
          Hash,
          Numeric,
          Integer,
          Float,
          Symbol,
          Kernel,
          Module,
          Class,
          Range,
          Regexp,
        ].map(&:to_s).freeze)

        def apply?(trace_data)
          !excluded_class?(trace_data.klass)
        end

        private

        def excluded_class?(klass)
          RUBY_CORE_CLASSES.include?(klass.to_s)
        end
      end
    end
  end
end
