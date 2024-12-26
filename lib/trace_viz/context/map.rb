# frozen_string_literal: true

module TraceViz
  module Context
    class Map
      def initialize
        @context_map = {}
      end

      def replace(new_map)
        @context_map = new_map
      end

      def fetch(key)
        @context_map.fetch(key)
      rescue KeyError
        raise ContextError, "Context for key '#{key}' not found"
      end

      def remove(*keys)
        keys.each { |key| @context_map.delete(key) }
      end

      def reset
        @context_map.clear
      end
    end
  end
end
