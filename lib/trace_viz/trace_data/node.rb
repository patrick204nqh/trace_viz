# frozen_string_literal: true

require_relative "base"

module TraceViz
  module TraceData
    class Node < Base
      attr_accessor :parent
      attr_reader :children

      def initialize
        super()

        @parent = nil
        @children = []
      end

      def add_child(node)
        node.parent = self
        @children << node
      end

      def add_children(nodes)
        nodes.each do |node|
          add_child(node)
        end
      end

      def to_h
        super.merge(
          {
            parent: parent&.to_s,
            children: children.map(&:to_h),
          },
        )
      end
    end
  end
end
