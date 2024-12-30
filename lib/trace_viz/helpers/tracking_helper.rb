# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module Helpers
    module TrackingHelper
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
