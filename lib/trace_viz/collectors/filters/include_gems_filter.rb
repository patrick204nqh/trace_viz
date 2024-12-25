# frozen_string_literal: true

require_relative "base_filter"

module TraceViz
  module Collectors
    module Filters
      class IncludeGemsFilter < BaseFilter
        def initialize(**options)
          super()
          @include_app = options.fetch(:app_running, false)
          @app_path = options[:app_path] || detect_app_path
          @app_path.freeze
          @included_gems = options.fetch(:gems, []).map do |gem_name|
            ::Gem.loaded_specs[gem_name]&.full_gem_path
          end.compact.freeze
        end

        def apply?(trace_data)
          app_path_included?(trace_data.path) || included_gem?(trace_data.path)
        end

        private

        attr_reader :include_app, :app_path, :included_gems

        def included_gem?(path)
          included_gems.any? { |gem_path| path.start_with?(gem_path) }
        end

        def app_path_included?(path)
          include_app && path.start_with?(app_path)
        end

        def detect_app_path
          if defined?(Bundler)
            Bundler.root.to_s
          else
            # Use the directory of the currently running script
            File.expand_path("..", $PROGRAM_NAME)
          end
        rescue StandardError
          # Fallback to current working directory
          Dir.pwd
        end
      end
    end
  end
end
