# frozen_string_literal: true

require "trace_viz/collectors/filters/registry"

module TraceViz
  module Config
    class Validator
      FILTER_KEYS = Collectors::Filters::Registry::FILTERS.keys.freeze

      def initialize
        @validations = {
          params: ->(value) { validate_params(value) },
          result: ->(value) { validate_result(value) },
          source_location: ->(value) { validate_source_location(value) },
          filters: ->(value) { validate_filters(value) },
          export: ->(value) { validate_export(value) },
        }
      end

      def validate(group, value)
        return unless @validations.key?(group)

        @validations[group].call(value)
      end

      private

      def validate_params(value)
        mode = value[:mode]
        unless Defaults.valid_param_modes.include?(mode)
          raise ArgumentError, "Invalid param mode: #{mode}. Valid modes are #{Defaults.valid_param_modes.join(", ")}."
        end

        if value[:truncate_values] && (!value[:truncate_values].is_a?(Integer) || value[:truncate_values] <= 0)
          raise ArgumentError, "Truncate values must be a positive integer."
        end
      end

      def validate_result(value)
        if value[:truncate_length] && (!value[:truncate_length].is_a?(Integer) || value[:truncate_length] <= 0)
          raise ArgumentError, "Truncate values must be a positive integer."
        end
      end

      def validate_source_location(value)
        if value[:truncate_length] && (!value[:truncate_length].is_a?(Integer) || value[:truncate_length] <= 0)
          raise ArgumentError, "Truncate length for source_location must be a positive integer."
        end

        if value[:filter_paths] && !value[:filter_paths].all? { |path| path.is_a?(Regexp) }
          raise ArgumentError, "All filter paths must be regular expressions."
        end
      end

      def validate_filters(filters)
        unless filters.is_a?(Array)
          raise ArgumentError, "Filters must be an array. Received: #{filters.class.name}"
        end
      end

      def validate_export(value)
        unless value.is_a?(Hash)
          raise ArgumentError, "Export configuration must be a hash."
        end

        format = value[:format]
        unless Defaults.valid_export_formats.include?(format)
          raise ArgumentError,
            "Invalid export format: #{format}. Valid formats are #{Defaults.valid_export_formats.join(", ")}."
        end
      end
    end
  end
end
