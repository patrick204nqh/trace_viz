# frozen_string_literal: true

require_relative "base_class_filter"

module TraceViz
  module Collectors
    module Filters
      class BaseIncludeFilter < BaseClassFilter
        def apply?(trace_data)
          klass_name = normalize_class_name(trace_data.klass)
          classes_and_modules.any? { |allowed| matches_hierarchy?(klass_name, allowed) }
        end
      end
    end
  end
end
