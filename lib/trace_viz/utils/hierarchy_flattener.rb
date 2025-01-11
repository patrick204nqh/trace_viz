# frozen_string_literal: true

module TraceViz
  module Utils
    class HierarchyFlattener
      class << self
        def flatten(root)
          result = []
          traverse(root) do |node|
            result << node
          end
          result
        end

        private

        # Make sure already have .children method
        def traverse(node, &block)
          yield node
          node.children.each do |child|
            traverse(child, &block)
          end
        end
      end
    end
  end
end
