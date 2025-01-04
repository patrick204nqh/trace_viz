# frozen_string_literal: true

require_relative "node"

module TraceViz
  module TraceData
    class SummaryNode < Node
      attr_reader :group, :count, :representative_node, :event, :klass, :action, :path, :params, :result

      def initialize(group:)
        super()

        @group = group
        @count = group.size

        @representative_node = group.first
        @depth = representative_node.depth
        @event = representative_node.event
        @klass = representative_node.klass
        @path = representative_node.path
        @action = representative_node.action

        # Representative node is the first node in the group belonging to MethodCall
        @params = representative_node.params
        @result = representative_node.method_return.result

        add_children(representative_node.children)
      end

      def average_duration
        return 0 if count.zero?

        total_duration / count
      end

      def total_duration
        children.map(&:duration).sum
      end

      private

      def add_children(nodes)
        nodes.each do |node|
          add_child(node)
        end
      end
    end
  end
end
