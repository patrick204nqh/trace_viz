# frozen_string_literal: true

require "trace_viz/collectors/filters/registry"
require_relative "base_step"

module TraceViz
  module Collectors
    module Steps
      class ValidationStep < BaseStep
        def initialize
          super()
          @filters = build_filters.freeze
        end

        def call(trace_data)
          trace_data if pass?(trace_data)
        end

        private

        attr_reader :filters

        def pass?(trace_data)
          filters.all? { |filter| filter.apply?(trace_data) }
        end

        def build_filters
          Collectors::Filters::Registry.build(config.filters)
        end
      end
    end
  end
end
