# frozen_string_literal: true

module TraceViz
  class Context
    class Depth
      attr_reader :current

      def initialize(current = 0)
        @current = current
      end

      def increment
        @current += 1
      end

      def decrement
        @current -= 1 if @current.positive?
      end

      def reset
        @current = 0
      end

      def zero?
        @current.zero?
      end
    end
  end
end
