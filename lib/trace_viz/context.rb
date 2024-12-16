# frozen_string_literal: true

require "trace_viz/context/manager"

module TraceViz
  module Context
    class << self
      def for(type)
        Manager.get_context(type)
      end
    end
  end
end
