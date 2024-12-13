# frozen_string_literal: true

require "trace_viz/context/base_context"

module TraceViz
  module Context
    class Manager
      @context_map = {}         # Hash to allow fast access by key
      @registered_contexts = {} # Registry for context classes

      class << self
        # Access the context map
        attr_reader :context_map

        # Register a context class with a specific key
        def register_context_type(key, context_class)
          validate_key!(key)
          validate_context_class!(context_class)

          if @registered_contexts.key?(key)
            raise ArgumentError, "Context type for key '#{key}' is already registered"
          end

          @registered_contexts[key] = context_class
        end

        # Create and register a new context based on the provided key
        # Defaults to BaseContext if key is nil or unregistered
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

        # Enter a new context and optionally associate it with a key
        def enter_context(key = nil, **options)
          create_context(key, **options)
        end

        # Enter multiple contexts at once by providing a Hash of contexts and options
        def enter_multiple_contexts(contexts_with_options = {})
          unless contexts_with_options.is_a?(Hash)
            raise ArgumentError, "Expected a Hash of contexts and options, got #{contexts_with_options.class}"
          end

          contexts_with_options.each do |key, options|
            enter_context(key, **options)
          end
        end

        # Exit a context by key, removing it from the context map
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

        # Get a specific context by key
        def get_context(key)
          validate_key!(key)
          @context_map[key]
        end

        # Clear all contexts from the context map
        def clear
          @context_map.clear
        end

        # Check if the context map is empty
        def empty?
          @context_map.empty?
        end

        # Retrieve all contexts as an array of hashes containing key and context information
        def all_contexts
          @context_map.map do |key, context|
            {
              key: key,
              context: context,
            }
          end
        end

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
