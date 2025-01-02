# frozen_string_literal: true

require_relative "node"

module TraceViz
  module TraceData
    class SummaryNode < Node
      attr_reader :event, :klass, :action, :count

      def initialize(group:, event:, klass:, action:)
        super()

        @event = event
        @klass = klass
        @action = action
        @count = group.size

        add_children(group.first.children)
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
