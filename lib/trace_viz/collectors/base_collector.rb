# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module Collectors
    class BaseCollector
      def initialize
        @collected_data = []
        @config = Context.for(:config).configuration
      end

      def collect(data)
        raise NotImplementedError
      end

      def collection
        @collected_data
      end

      def clear
        @collected_data = []
      end

      private

      attr_reader :config
    end
  end
end
