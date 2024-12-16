# frozen_string_literal: true

module TraceViz
  module Context
    class Manager
      module ContextMap
        def get_context(key)
          validate_key!(key)
          @context_map[key]
        end

        def clear
          @context_map.clear
        end

        def empty?
          @context_map.empty?
        end

        def all_contexts
          @context_map.map do |key, context|
            {
              key: key,
              context: context,
            }
          end
        end
      end
    end
  end
end
