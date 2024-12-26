# frozen_string_literal: true

require "trace_viz/context/map"
require "trace_viz/context/registry"

module TraceViz
  module Context
    class Manager
      @map = Map.new

      class << self
        def enter_contexts(contexts)
          @map.replace(Registry.build(contexts))
        end

        def exit_contexts(*keys)
          @map.remove(*keys)
        end

        def with_contexts(contexts = {})
          enter_contexts(contexts)
          yield
        ensure
          exit_contexts(*contexts.keys)
        end

        def fetch_context(key)
          @map.fetch(key)
        end
      end
    end
  end
end
