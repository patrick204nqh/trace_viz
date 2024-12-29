# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module Collectors
    module Steps
      class BaseStep
        def initialize
          @logger = TraceViz.logger
        end

        def call
          raise NotImplementedError
        end

        private

        attr_reader :logger

        def config
          Context.for(:config).configuration
        end

        def tracker
          Context.for(:tracking)
        end

        # Helper methods to access tracker attributes
        def active_call_stack
          tracker.active_calls
        end

        def current_call
          tracker.current_call
        end

        def current_depth
          tracker.current_depth
        end
      end
    end
  end
end
