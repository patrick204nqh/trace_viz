# frozen_string_literal: true

module TraceViz
  module Renderers
    class BaseRenderer
      def initialize(data)
        @data = data
      end

      def render
        to_lines.map { |line| line[:line] }.join("\n")
      end

      def to_lines
        []
      end

      private

      attr_reader :data
    end
  end
end
