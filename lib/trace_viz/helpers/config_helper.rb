# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module Helpers
    module ConfigHelper
      def config
        Context.for(:config).configuration
      end
    end
  end
end
