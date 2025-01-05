# frozen_string_literal: true

module TraceViz
  module Formatters
    class BaseFormatterFactory
      def initialize(formatters)
        @formatters = formatters.freeze
      end

      def fetch_formatter(key)
        @formatters.fetch(key) do
          raise ArgumentError, "Unsupported formatter key: #{key}. Available keys: #{available_keys.join(", ")}"
        end
      end

      private

      def available_keys
        @formatters.keys
      end
    end
  end
end
