# frozen_string_literal: true

module TraceViz
  module Utils
    module FormatUtils
      class ValueTruncator
        DEFAULT_LENGTH = -1

        def initialize(length: DEFAULT_LENGTH)
          @length = length
          validate_length!
        end

        def truncate(value)
          return value if @length.negative?

          case value
          when String then truncate_string(value)
          when Array then truncate_array(value)
          when Hash then truncate_hash(value)
          else truncate_generic(value)
          end
        end

        private

        def validate_length!
          raise ArgumentError, "Length must be an integer" unless @length.is_a?(Integer)
        end

        # Truncates a string
        def truncate_string(string)
          string.length > @length ? "#{string[0, @length]}..." : string
        end

        def truncate_array(array)
          truncated = array.take(@length)
          truncated << "..." if array.size > @length
          truncated
        end

        def truncate_hash(hash)
          keys = hash.keys.take(@length)
          truncated_pairs = keys.map { |key| "#{key}: #{truncate(hash[key])}" }
          truncated_pairs << "..." if hash.size > @length
          "{#{truncated_pairs.join(", ")}}"
        end

        def truncate_generic(object)
          object_str = object.inspect
          object_str.length > @length ? "#{object.class}(#{object_str[0, @length]}...)" : object_str
        end
      end
    end
  end
end
