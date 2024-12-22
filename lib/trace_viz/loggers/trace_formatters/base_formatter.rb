# frozen_string_literal: true

require "trace_viz/formatters/base_formatter"
require "trace_viz/utils/colorize"

module TraceViz
  module Loggers
    module TraceFormatters
      class BaseFormatter < Formatters::BaseFormatter
        private

        def colorize(text, color_key)
          Utils::Colorize.colorize(text, color_key)
        end
      end
    end
  end
end
