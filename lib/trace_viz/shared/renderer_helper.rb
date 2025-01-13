# frozen_string_literal: true

module TraceViz
  module Shared
    module RendererHelper
      def process_lines(lines, &block)
        return [] unless lines.is_a?(Array)

        lines.map do |line|
          validate_line_structure!(line)
          block.call(line)
        end.compact
      end

      private

      def validate_line_structure!(line)
        unless line.respond_to?(:line) && line.respond_to?(:data)
          raise ArgumentError,
            "Invalid line structure: #{line.inspect}. Expected an object with :line and :data attributes."
        end
      end
    end
  end
end
