# frozen_string_literal: true

module TraceViz
  module Collectors
    module Filters
      class ExcludeGemsFilter < BaseFilter
        def initialize(**options)
          super()
          @excluded_gems = options[:gems].map do |gem_name|
            ::Gem.loaded_specs[gem_name]&.full_gem_path
          end.compact.freeze
        end

        def apply?(trace_data)
          !excluded_gem?(trace_data.path)
        end

        private

        attr_reader :excluded_gems

        def excluded_gem?(path)
          excluded_gems.any? { |gem_path| path.start_with?(gem_path) }
        end
      end
    end
  end
end
