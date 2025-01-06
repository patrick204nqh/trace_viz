# frozen_string_literal: true

module TraceViz
  module Renderers
    class BaseRenderer
      NodeLine = Struct.new(:data, :line)

      def initialize(collector, context:)
        @collector = collector
        @context = context
      end

      def render
        to_lines.map { |line| line[:line] }.join("\n")
      end

      # [ { line: 'line1' }, { line: 'line2' } ]
      def to_lines
        []
      end

      private

      attr_reader :collector, :context
    end
  end
end
