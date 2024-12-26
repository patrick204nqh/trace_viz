# frozen_string_literal: true

require "trace_viz/formatters/base_formatter"
require "trace_viz/utils/colorize"

module TraceViz
  module Loggers
    module TraceFormatters
      class BaseFormatter < TraceViz::Formatters::BaseFormatter
        private

        def colorize(text, *styles)
          Utils::Colorize.colorize(text, *styles)
        end

        def formatted_depth
          return unless config.general[:show_depth]

          prefix = colorize("depth", :dip, :italic, :blue)
          open_block = colorize("[", :dip, :light_blue)
          number = colorize(trace_data.depth, :light_red)
          close_block = colorize("]", :dip, :light_blue)

          [
            prefix,
            open_block,
            number,
            close_block,
          ].join
        end

        def formatted_method_name
          return unless config.general[:show_method_name]

          "#{formatted_class_name}#{formatted_action_name}"
        end

        def formatted_class_name
          klass = colorize(trace_data.klass, :light_green)
          method_sign = colorize("#", :blue)

          [klass, method_sign].join
        end

        def formatted_action_name
          colorize(trace_data.action, :bold, :light_cyan)
        end
      end
    end
  end
end
