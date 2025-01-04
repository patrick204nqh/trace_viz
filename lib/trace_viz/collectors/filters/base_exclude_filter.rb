# frozen_string_literal: true

require_relative "base_class_filter"

module TraceViz
  module Collectors
    module Filters
      class BaseExcludeFilter < BaseClassFilter
        def apply?(trace_data)
          klass_name = normalize_class_name(trace_data.klass)
          !classes_and_modules.any? { |excluded| matches_hierarchy?(klass_name, excluded) }
        end
      end
    end
  end
end
