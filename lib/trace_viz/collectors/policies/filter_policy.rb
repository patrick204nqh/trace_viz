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

        def build_filters
          Collectors::Filters::Registry.build(config.filters)
        end
      end
    end
  end
end
