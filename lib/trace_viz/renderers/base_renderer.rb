# frozen_string_literal: true

module TraceViz
  module Renderers
    class BaseRenderer
      def initialize(data)
        @data = data
      end

      def render
        raise NotImplementedError
      end

      def to_lines
        []
      end

      private

      attr_reader :data
    end
  end
end
