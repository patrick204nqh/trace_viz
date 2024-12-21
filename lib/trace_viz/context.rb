# frozen_string_literal: true

require "trace_viz/context/manager"

module TraceViz
  module Context
    class << self
      def for(key)
        Manager.fetch_context(key)
      end
    end
  end
end
