# frozen_string_literal: true

require "trace_viz/context/manager/context_map"
require "trace_viz/context/manager/context_validation"
require "trace_viz/context/manager/context_registry"
require "trace_viz/context/manager/context_operations"

module TraceViz
  module Context
    class Manager
      class << self
        include ContextMap
        include ContextValidation
        include ContextRegistry
        include ContextOperations

        # Initialize class instance variables
        def initialize_manager
          @context_map = {}
          @registered_contexts = {}
        end
      end

      # Ensure initialization upon loading
      initialize_manager
    end
  end
end
