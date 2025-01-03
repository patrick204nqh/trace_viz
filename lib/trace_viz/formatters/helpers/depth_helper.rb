# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module DepthHelper
        def depth_representation(trace_data)
          return unless config.general[:show_depth]

          "depth[#{trace_data.depth}]"
        end
      end
    end
  end
end
