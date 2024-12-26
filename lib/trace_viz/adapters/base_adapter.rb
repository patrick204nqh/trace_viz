# frozen_string_literal: true

require "trace_viz/context"
require "trace_viz/exporters/registry"

module TraceViz
  module Adapters
    class BaseAdapter
      def initialize
        @config = Context.for(:config).configuration
      end

      def trace
        raise NotImplementedError
      end

      private

      attr_reader :config
    end
  end
end
