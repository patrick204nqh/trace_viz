# frozen_string_literal: true

require "trace_viz/context/config_context"
require "trace_viz/context/tracking_context"
require "trace_viz/context/manager"

module TraceViz
  module Context
    class << self
      def for(type)
        Manager.get_context(type)
      end
    end

    Manager.register_context_type(:config, ConfigContext)
    Manager.register_context_type(:tracking, TrackingContext)
  end
end
