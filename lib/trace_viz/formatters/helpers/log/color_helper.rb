# frozen_string_literal: true

require "trace_viz/utils/colorize"

module TraceViz
  module Formatters
    module Helpers
      module Log
        module ColorHelper
          def colorize_for(text, action)
            colors = Defaults::Actions.colors_for(action)

            colorize(text, *colors)
          end

          def colorize(text, *colors)
            Utils::Colorize.colorize(text, *colors)
          end
        end
      end
    end
  end
end
