# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module DepthHelper
        def depth_if_enabled
          return unless config.general[:show_depth]

          "#depth:#{trace_data.depth}"
        end
      end
    end
  end
end
