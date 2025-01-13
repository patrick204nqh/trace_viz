# frozen_string_literal: true

require_relative "node"

module TraceViz
  module TraceData
    class RootNode < Node
      def initialize
        super()

        # Explicitly ensure no parent for root
        @parent = nil
      end

      def root?
        true
      end

      def parent=(_parent)
        raise NoMethodError, "RootNode cannot have a parent"
      end
    end
  end
end
