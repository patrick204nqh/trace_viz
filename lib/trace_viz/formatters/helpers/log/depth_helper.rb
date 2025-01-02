# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module Log
        module DepthHelper
          def format_depth(trace_data, config)
            return unless config.general[:show_depth]

            prefix = colorize("depth", :trace_depth_prefix)
            open_block = colorize("[", :trace_depth_open)
            number = colorize(trace_data.depth, :trace_depth_value)
            close_block = colorize("]", :trace_depth_close)

            [prefix, open_block, number, close_block].join
          end
        end
      end
    end
  end
end
