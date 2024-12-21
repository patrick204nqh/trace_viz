# frozen_string_literal: true

require "trace_viz/collectors/filters/base_filter"

module TraceViz
  module Collectors
    module Filters
      class ExcludeInternalCallFilter < BaseFilter
        INTERNAL_PATH_IDENTIFIER = "<internal:"
        INTERNAL_CLASS_PREFIX = "TracePoint"

        def apply?(trace_data)
          [
            internal_path?(trace_data.path),
            internal_class?(trace_data.klass),
          ].none?
        end

        private

        def internal_path?(path)
          path.include?(INTERNAL_PATH_IDENTIFIER)
        end

        def internal_class?(klass)
          klass.to_s.start_with?(INTERNAL_CLASS_PREFIX)
        end
      end
    end
  end
end
