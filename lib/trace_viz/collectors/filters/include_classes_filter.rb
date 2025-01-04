# frozen_string_literal: true

require_relative "base_include_filter"

module TraceViz
  module Collectors
    module Filters
      class IncludeClassesFilter < BaseIncludeFilter
        def initialize(classes:)
          super(classes: classes)
        end
      end
    end
  end
end
