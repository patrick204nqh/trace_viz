# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module TraceData
    class Base
      attr_reader :config

      def initialize
        @logger = TraceViz.logger
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

      def log_trace
        raise NotImplementedError
      end

      private

      attr_reader :logger, :tracker

      def should_log?
        config.show_trace_events.include?(event)
      end
    end
  end
end
