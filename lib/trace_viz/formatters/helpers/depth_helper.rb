# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module DepthHelper
        def depth_representation
          return unless config.general[:show_depth]

          if trace_data.depth.zero?
            "depth[0]"
          elsif trace_data.event == :call
            "depth[#{trace_data.depth}]"
          elsif trace_data.event == :return
            "depth[#{trace_data.depth}]"
          end
        end
      end
    end
  end
end
