# frozen_string_literal: true

require_relative "format_utils/key_value_formatter"
require_relative "format_utils/value_truncator"

module TraceViz
  module Utils
    module FormatUtils
      class << self
        # Formats key-value pairs based on the provided mode
        def format_key_value_pairs(data, mode)
          formatter = KeyValueFormatter.new(mode: mode)
          formatter.call(data)
        end

        # Truncates a value to the specified length
        def truncate_value(value, length, direction: :end)
          truncator = ValueTruncator.new(length: length, direction: direction)
          truncator.truncate(value)
        end
      end
    end
  end
end
