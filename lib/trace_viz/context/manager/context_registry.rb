# frozen_string_literal: true

module TraceViz
  module Context
    class Manager
      module ContextRegistry
        def register_context_type(key, context_class)
          validate_key!(key)
          validate_context_class!(context_class)

          if @registered_contexts.key?(key)
            raise ArgumentError, "Context type for key '#{key}' is already registered"
          end

          @registered_contexts[key] = context_class
        end
      end
    end
  end
end
