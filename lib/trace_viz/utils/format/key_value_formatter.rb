# frozen_string_literal: true

module TraceViz
  module Utils
    module Format
      module KeyValueFormatter
        DEFAULT_MODE = :name_and_value
        VALID_MODES = [:name_and_value, :name_only, :value_only].freeze

        class << self
          def format_pairs(data, mode: DEFAULT_MODE)
            validate_input(data)
            formatter = build_formatter(mode)
            data.map { |key, value| formatter.call(key, value) }.join(", ")
          end

          private

          def validate_input(data)
            raise ArgumentError,
              "Expected a Hash for data, but received #{data.class}. Please pass a valid Hash." unless data.is_a?(Hash)
          end

          def build_formatter(mode)
            unless VALID_MODES.include?(mode)
              raise ArgumentError, "Invalid mode: #{mode}. Valid modes are: #{VALID_MODES.join(", ")}."
            end

            case mode
            when :name_and_value
              ->(key, value) { "#{key}: #{value}" }
            when :name_only
              ->(key, _) { key.to_s }
            when :value_only
              ->(_, value) { value.to_s }
            end
          end
        end
      end
    end
  end
end
