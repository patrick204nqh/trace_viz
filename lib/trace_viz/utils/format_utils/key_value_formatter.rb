# frozen_string_literal: true

module TraceViz
  module Utils
    module FormatUtils
      class KeyValueFormatter
        DEFAULT_MODE = :name_and_value

        def initialize(mode: DEFAULT_MODE)
          @mode = mode
          @formatter = build_formatter
        end

        def format(data)
          validate_input(data)
          data.map { |key, value| @formatter.call(key, value) }.join(", ")
        end

        private

        def validate_input(data)
          unless data.is_a?(Hash)
            raise ArgumentError, "Expected a Hash for key-value formatting, got #{data.class}"
          end
        end

        def build_formatter
          {
            name_and_value: ->(key, value) { "#{key}: #{value}" },
            name_only: ->(key, _) { key.to_s },
            value_only: ->(_, value) { value.to_s },
          }.fetch(@mode) { raise ArgumentError, "Invalid mode: #{@mode}" }
        end
      end
    end
  end
end
