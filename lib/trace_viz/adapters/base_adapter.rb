# frozen_string_literal: true

require "trace_viz/context"

module TraceViz
  module Adapters
    class BaseAdapter
      def trace
        raise NotImplementedError
      end
    end
  end
end
