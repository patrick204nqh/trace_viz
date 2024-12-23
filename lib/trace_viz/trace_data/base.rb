# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module TraceData
    class Base
      attr_reader :config
      attr_accessor :depth

      def initialize
        @config = Context.for(:config).configuration
        @depth = 0
      end

      def id
        raise NotImplementedError
      end

      def event
        raise NotImplementedError
      end

      def path
        raise NotImplementedError
      end

      def line_number
        raise NotImplementedError
      end

      def klass
        raise NotImplementedError
      end
    end
  end
end
