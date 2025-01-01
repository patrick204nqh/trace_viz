# frozen_string_literal: true

require "trace_viz/trace_data/root_node"

module TraceViz
  module TraceData
    class HierarchyLinker
      attr_reader :root

      def initialize
        @root = RootNode.new
      end

      def link(trace_data)
        return unless valid?(trace_data)

        root.add_child(trace_data)
      end

      private

      def valid?(trace_data)
        [
          trace_data.event == :call,
          trace_data.parent.nil?,
        ].all?
      end
    end
  end
end
