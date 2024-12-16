# frozen_string_literal: true

module TraceViz
  module Context
    class Manager
      module ContextValidation
        private

        # Validate that the key is either a Symbol or String
        def validate_key!(key)
          return unless key

          unless key.is_a?(Symbol) || key.is_a?(String)
            raise ArgumentError, "Key must be a Symbol or String, got #{key.class}"
          end
        end

        # Ensure that the key is unique (no existing context with the same key)
        def ensure_unique_key!(key)
          if @context_map.key?(key)
            raise ArgumentError, "Context with key '#{key}' already exists"
          end
        end

        # Validate that the context_class inherits from BaseContext
        def validate_context_class!(context_class)
          unless context_class < BaseContext
            raise ArgumentError, "Context class must inherit from BaseContext"
          end
        end
      end
    end
  end
end
