# frozen_string_literal: true

require_relative "base_filter"

module TraceViz
  module Collectors
    module Filters
      class BaseClassFilter < BaseFilter
        def initialize(classes:)
          super()
          @classes_and_modules = classes.map(&:to_s).freeze
        end

        protected

        attr_reader :classes_and_modules

        def normalize_class_name(klass)
          # Normalize class/module names to handle dynamic/nested representations
          klass.to_s
            .gsub(/^#<Class/, "<Class")
            .strip
        end

        def matches_hierarchy?(klass_name, target_name)
          klass_name == target_name || klass_name.start_with?("#{target_name}::")
        end
      end
    end
  end
end
