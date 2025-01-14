# frozen_string_literal: true

require_relative "format_utils/key_value_formatter"

module TraceViz
  module Utils
    module FormatUtils
      class << self
        # Formats key-value pairs based on the provided mode
        def format_key_value_pairs(data, mode)
          formatter = KeyValueFormatter.new(mode: mode)
          formatter.call(data)
        end
      end
    end
  end
end
