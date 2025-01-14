# frozen_string_literal: true

module TraceViz
  module Utils
    module Format
      module ValueTruncator
        DEFAULT_LENGTH = -1
        VALID_DIRECTIONS = [:start, :end].freeze

        class << self
          def truncate(value, length: DEFAULT_LENGTH, direction: :end, hash_length: DEFAULT_LENGTH)
            validate_params(length, direction, hash_length)

            # Skip truncation if length is not positive
            return value unless length.positive?

            opts = {
              value: value,
              length: length,
              direction: direction,
              hash_length: hash_length,
            }

            case value
            when String then truncate_string(opts)
            when Array then truncate_array(opts)
            when Hash then truncate_hash(opts)
            else truncate_object(opts)
            end
          end

          private

          def validate_params(length, direction, hash_length)
            validate_length(length)
            validate_length(hash_length)
            validate_direction(direction)
          end

          def validate_length(val)
            return if val.is_a?(Integer) && (val.positive? || val == DEFAULT_LENGTH)

            raise ArgumentError, "Invalid length: #{val}. Must be a positive Integer or -1."
          end

          def validate_direction(direction)
            return if VALID_DIRECTIONS.include?(direction)

            raise ArgumentError, "Invalid direction: #{direction}. Valid options are :start or :end."
          end

          def truncate_string(opts)
            string = opts[:value]
            length = opts[:length]
            direction = opts[:direction]

            return string if string.length <= length

            case direction
            when :start then "...#{string[-length..]}"
            when :end then "#{string[0, length]}..."
            end
          end

          def truncate_array(opts)
            array = opts[:value]
            length = opts[:length]

            return array if array.size <= length

            truncated = array.take(length)
            truncated << "..." if array.size > length
            truncated
          end

          def truncate_hash(opts)
            hash = opts[:value]
            length = opts[:length]
            direction = opts[:direction]
            hash_length = opts[:hash_length]

            truncated_keys = hash.keys.take(length)

            truncated_parts = truncated_keys.map do |key|
              "#{key}: #{truncate(hash[key], **opts.except(:value))}"
            end

            truncated_parts << "..." if hash.size > length
            format_hash(
              content: truncated_parts.join(", "),
              direction: direction,
              hash_length: hash_length,
            )
          end

          def format_hash(content:, direction:, hash_length:)
            # Only truncate the final string if hash_length is positive
            return "{#{content}}" unless hash_length.positive?

            case direction
            when :start then "{...#{content[-hash_length..]}}"
            when :end then "{#{content[0, hash_length]}...}"
            end
          end

          def truncate_object(opts)
            object = opts[:value]
            length = opts[:length]
            direction = opts[:direction]

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
end
