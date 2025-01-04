# frozen_string_literal: true

require_relative "base_exclude_filter"

module TraceViz
  module Collectors
    module Filters
      class ExcludeClassesFilter < BaseExcludeFilter
        def initialize(classes:)
          super(classes: classes)
        end
      end
    end
  end
end
