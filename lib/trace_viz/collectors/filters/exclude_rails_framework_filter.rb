# frozen_string_literal: true

require "trace_viz/collectors/filters/base_filter"

module TraceViz
  module Collectors
    module Filters
      class ExcludeRailsFrameworkFilter < BaseFilter
        RAILS_MODULES = [
          "ActiveSupport",
          "ActionController",
          "ActionView",
          "ActiveRecord",
          "Rails",
          # Additional Rails modules
          "ActionDispatch",
          "Zeitwerk",
          "ViewComponent",
        ].freeze

        def apply?(trace_data)
          !rails_related?(trace_data.klass)
        end

        private

        def rails_related?(klass)
          RAILS_MODULES.any? { |mod| klass.to_s.start_with?(mod) }
        end
      end
    end
  end
end
