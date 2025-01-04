# frozen_string_literal: true

require_relative "base_exclude_filter"

module TraceViz
  module Collectors
    module Filters
      class ExcludeDefaultClassesFilter < BaseExcludeFilter
        DEFAULT_CLASSES_AND_MODULES = [
          "Object",
          "String",
          "Array",
          "Hash",
          "Numeric",
          "Integer",
          "Float",
          "Symbol",
          "Kernel",
          "Module",
          "Class",
          "Range",
          "Regexp",
          "BigDecimal",
          "Set",
          "Gem",
        ].freeze

        def initialize
          super(classes: DEFAULT_CLASSES_AND_MODULES)
        end
      end
    end
  end
end
