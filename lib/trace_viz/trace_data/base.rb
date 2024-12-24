# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module TraceData
    class Base
      attr_reader :config,
        :timestamp
      attr_accessor :depth

      def initialize
        @config = Context.for(:config).configuration

        @depth = 0
        record_timestamp
      end

      # A unique identifier for each object in memory
      def id
        raise NotImplementedError
      end

      def action
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

      private

      def record_timestamp
        @timestamp = Time.now
      end
    end
  end
end
