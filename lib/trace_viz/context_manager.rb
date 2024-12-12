# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  class ContextManager
    @contexts = []

    class << self
      # Access the stack (global registry)
      def stack
        @contexts
      end

      # Get the current context (top of the stack)
      def current
        stack.last
      end

      # Enter a new context and push it onto the stack
      def enter_context
        context = Context.new
        stack.push(context)
        context
      end

      # Exit the current context and remove it from the stack
      def exit_context
        raise "No context to exit" if stack.empty?

        stack.pop
      end

      # Clear the entire stack (useful for testing or debugging)
      def clear
        stack.clear
      end

      # Check if the stack is empty
      def empty?
        stack.empty?
      end
    end
  end
end
