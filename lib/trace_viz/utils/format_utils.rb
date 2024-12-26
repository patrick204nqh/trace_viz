# frozen_string_literal: true

module TraceViz
  module Utils
    module FormatUtils
      class << self
        # Formats a hash or array of key-value pairs based on the specified mode
        def format_key_value_pairs(data, mode)
          data.map { |key, value| display_mode(mode).call(key, value) }.join(", ")
        end

        # Determines how key-value pairs are displayed based on the mode
        def display_mode(mode)
          {
            name_and_value: ->(name, value) { "#{name}: #{value}" },
            name_only: ->(name, _) { name.to_s },
            value_only: ->(_, value) { value },
          }.fetch(mode)
        end

        # Truncates a string or array to the specified length
        def truncate_value(value, length)
          return value unless length.is_a?(Integer) && length.positive?

          case value
          when String
            truncate_string(value, length)
          when Array
            truncate_array(value, length)
          when Hash
            truncate_hash(value, length)
          else
            truncate_object(value, length)
          end
        end

        private

        def truncate_string(string, length)
          string.length > length ? "#{string[0, length]}..." : string
        end

        def truncate_array(array, length)
          truncated_array = array.take(length)
          truncated_array << "..." if array.size > length
          truncated_array
        end

        def truncate_hash(hash, length)
          keys = hash.keys.take(length)
          truncated_pairs = keys.map { |key| "#{key}: #{truncate_value(hash[key], length)}" }
          truncated_pairs << "..." if hash.size > length
          "{#{truncated_pairs.join(", ")}}"
        end

        def truncate_object(object, length)
          object_string = object.inspect
          if object.is_a?(Hash) || object.is_a?(Array)
            truncate_value(object, length)
          else
            object_string.length > length ? "#{object.class}(#{object_string[0, length]}...)" : object_string
          end
        end
      end
    end
  end
end
