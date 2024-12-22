# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module TraceData
    class Base
      attr_reader :config

      def initialize
        @config = Context.for(:config).configuration
        @tracker = Context.for(:tracking)
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

      def params
        raise NotImplementedError
      end

      def result
        raise NotImplementedError
      end

      private

      attr_reader :tracker
    end
  end
end
