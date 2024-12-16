# frozen_string_literal: true

require "trace_viz/context/base_context"

module TraceViz
  module Context
    class Manager
      module ContextOperations
        def create_context(key = nil, **options)
          if key
            validate_key!(key)
            ensure_unique_key!(key)
          end

          context_class = @registered_contexts[key] || BaseContext
          context = context_class.new(**options)
          @context_map[key] = context if key
          context
        end

        def enter_context(key = nil, **options)
          create_context(key, **options)
        end

        def enter_multiple_contexts(contexts_with_options = {})
          unless contexts_with_options.is_a?(Hash)
            raise ArgumentError, "Expected a Hash of contexts and options, got #{contexts_with_options.class}"
          end

          contexts_with_options.each do |key, options|
            enter_context(key, **options)
          end
        end

        def exit_context(key)
          validate_key!(key)
          context = @context_map.delete(key)
          raise ArgumentError, "No context found with key '#{key}' to exit" unless context

          context
        end

        def exit_multiple_contexts(*keys)
          keys.each do |key|
            validate_key!(key)
            exit_context(key)
          end
        end

        # Execute a block within the context(s) specified
        def with_contexts(contexts_with_options = {})
          enter_multiple_contexts(contexts_with_options)
          yield
        ensure
          exit_multiple_contexts(*contexts_with_options.keys)
        end
      end
    end
  end
end
