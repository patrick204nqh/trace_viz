# frozen_string_literal: true

module TraceViz
  module Config
    class Validator
      def initialize
        @validations = {
          param_display_mode: ->(value) { validate_param_display_mode(value) },
          tab_size: ->(value) { validate_positive_integer(value) },
          export: ->(value) { validate_export(value) },
        }
      end

      def validate(attribute, value)
        return unless @validations.key?(attribute)

        @validations[attribute].call(value)
      end

      private

      def validate_param_display_mode(value)
        unless Defaults.valid_param_display_modes.include?(value)
          raise ArgumentError,
            "Invalid param_display_mode: #{value}. Valid modes are #{Defaults.valid_param_display_modes.join(", ")}."
        end
      end

      def validate_positive_integer(value)
        unless value.is_a?(Integer) && value.positive?
          raise ArgumentError, "Invalid value for tab_size: #{value}. Must be a positive integer."
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
