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

        def formatted_method_name
          return unless config.general[:show_method_name]

          "#{formatted_class_name}#{formatted_action_name}"
        end

        def formatted_class_name
          colorize("#{trace_data.klass}#", :light_green)
        end

        def formatted_action_name
          colorize(trace_data.action, :bold, :light_cyan)
        end

        def formatted_depth
          return unless config.general[:show_depth]

          depth_prefix = colorize("depth", :dip, :italic, :blue)
          depth_open_block = colorize("[", :dip, :light_blue)
          depth_number = colorize(trace_data.depth, :light_red)
          depth_close_block = colorize("]", :dip, :light_blue)

          [
            depth_prefix,
            depth_open_block,
            depth_number,
            depth_close_block,
          ].join
        end
      end
    end
  end
end
