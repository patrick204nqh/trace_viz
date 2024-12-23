# frozen_string_literal: true

require "trace_viz/collectors/filters/registry"
require_relative "base_policy"

module TraceViz
  module Collectors
    module Policies
      class FilterPolicy < BasePolicy
        def initialize
          super()
          @filters = build_filters.freeze
        end

        def applicable?(trace_data)
          filters.all? { |filter| filter.apply?(trace_data) }
        end

        private

        attr_reader :filters

        def combine_filters
          Array(config.filters) + Array(config.default_filters)
        end

        def build_filters
          Collectors::Filters::Registry.build(combine_filters)
        end
      end
    end
  end
end
