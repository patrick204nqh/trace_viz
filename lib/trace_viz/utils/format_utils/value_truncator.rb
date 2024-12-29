# frozen_string_literal: true

module TraceViz
  module Utils
    module FormatUtils
      class ValueTruncator
        DEFAULT_LENGTH = -1
        VALID_DIRECTIONS = [:start, :end].freeze

        def initialize(length: DEFAULT_LENGTH, direction: :end)
          @length = length
          @direction = validate_direction(direction)
        end

        def truncate(value)
          return value unless valid_length?

          case value
          when String then truncate_string(value)
          when Array then truncate_array(value)
          when Hash then truncate_hash(value)
          else truncate_generic(value)
          end
        end

        private

        attr_reader :length, :direction

        def validate_direction(direction)
          return direction if VALID_DIRECTIONS.include?(direction)

          raise ArgumentError, "Invalid direction: #{direction}. Valid options are :start or :end."
        end

        def valid_length?
          length.is_a?(Integer) && length.positive?
        end

        def truncate_string(string)
          return string if string.length <= length

          case direction
          when :start then "...#{string[-length..]}"
          when :end then "#{string[0, length]}..."
          end
        end

        def truncate_array(array)
          truncated = array.take(length)
          truncated << "..." if array.size > length
          truncated
        end

        def truncate_hash(hash)
          keys = hash.keys.take(length)
          truncated_pairs = keys.map { |key| "#{key}: #{truncate(hash[key])}" }
          truncated_pairs << "..." if hash.size > length
          "{#{truncated_pairs.join(", ")}}"
        end

        def truncate_generic(object)
          object_str = object.inspect
          return object_str if object_str.length <= length

          case direction
          when :start then "#{object.class}(...#{object_str[-length..]})"
          when :end then "#{object.class}(#{object_str[0, length]}...)"
          end
        end
      end
    end
  end
end
