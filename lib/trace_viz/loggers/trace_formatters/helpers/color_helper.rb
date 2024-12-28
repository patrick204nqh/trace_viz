# frozen_string_literal: true

require "trace_viz/utils/colorize"

module TraceViz
  module Loggers
    module TraceFormatters
      module Helpers
        module ColorHelper
          private

          def colorize(text, *styles)
            Utils::Colorize.colorize(text, *styles)
          end
        end
      end
    end
  end
end
