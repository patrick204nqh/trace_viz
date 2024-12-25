# frozen_string_literal: true

module TraceViz
  module Config
    class Copier
      def initialize(configuration)
        @origin_configuration = configuration
        @settings = origin_configuration.settings
      end

      def copy
        copied_settings = deep_copy(settings)
        copy = origin_configuration.class.new
        copied_settings.each { |key, value| copy.update(key, value) }
        copy
      end

      private

      attr_reader :origin_configuration, :settings

      def deep_copy(value)
        case value
        when Hash
          value.transform_values { |v| deep_copy(v) }
        when Array
          value.map { |v| deep_copy(v) }
        else
          begin
            value.dup
          rescue TypeError
            value # Return immutable objects as-is
          end
        end
      end
    end
  end
end
