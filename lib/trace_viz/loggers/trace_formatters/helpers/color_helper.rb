# frozen_string_literal: true

require "trace_viz/utils/colorize"

module TraceViz
  module Loggers
    module TraceFormatters
      module Helpers
        module ColorHelper
          private

          def colorize(text, action)
            colors = Defaults.action_colors_for(action)

            Utils::Colorize.colorize(text, *colors)
          end
        end
      end
    end
  end
end
