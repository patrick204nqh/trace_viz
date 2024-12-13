# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  class ContextManager
    @contexts = []        # Stack to maintain order
    @context_map = {}     # Hash to allow fast access by key

    class << self
      # Access the stack (global registry)
      def stack
        @contexts
      end

      # Access the context map
      attr_reader :context_map

      # Get the current context (top of the stack)
      def current
        stack.last
      end

      # Enter a new context and optionally associate it with a key
      def enter_context(key = nil)
        if key && context_map.key?(key)
          raise ArgumentError, "Context with key '#{key}' already exists"
        end

        context = Context.new
        stack.push(context)
        context_map[key] = context if key
        context
      end

      # Exit the current context, removing it from both the stack and the key map
      def exit_context
        raise "No context to exit" if stack.empty?

        context = stack.pop
        context_map.delete(context_map.key(context))
        context
      end

      # Get a specific context by key
      def get_context(key)
        context_map[key]
      end

      # Remove a context by key (also removes it from the stack)
      def remove_context(key)
        context = context_map.delete(key)
        if context
          stack.delete(context)
        end
        context
      end

      # Clear the entire stack and context map
      def clear
        stack.clear
        context_map.clear
      end

      # Check if the stack is empty
      def empty?
        stack.empty?
      end

      # Retrieve all contexts as an array of hashes with optional key information
      def all_contexts
        stack.map do |context|
          {
            key: context_map.key(context),
            context: context,
          }
        end
      end
    end
  end
end
