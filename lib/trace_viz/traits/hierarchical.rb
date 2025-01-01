# frozen_string_literal: true

module TraceViz
  module Traits
    module Hierarchical
      attr_reader :parent, :children

      def initialize_hierarchical
        @parent = nil
        @children = []
      end

      def add_child(child)
        child.parent = self
        @children << child
      end

      def traverse(&block)
        yield self
        @children.each { |child| child.traverse(&block) }
      end
    end
  end
end
