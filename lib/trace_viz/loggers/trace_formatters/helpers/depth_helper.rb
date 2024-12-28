# frozen_string_literal: true

module TraceViz
  module Loggers
    module TraceFormatters
      module Helpers
        module DepthHelper
          def format_depth(trace_data, config)
            return unless config.general[:show_depth]

            prefix = colorize("depth", :dip, :italic, :blue)
            open_block = colorize("[", :dip, :light_blue)
            number = colorize(trace_data.depth, :light_red)
            close_block = colorize("]", :dip, :light_blue)

            [prefix, open_block, number, close_block].join
          end
        end
      end
    end
  end
end
