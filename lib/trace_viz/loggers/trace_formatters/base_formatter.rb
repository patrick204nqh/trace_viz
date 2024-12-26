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
          colorize("#{trace_data.klass}#", :bold, :yellow)
        end

        def formatted_action_name
          colorize(trace_data.action, :light_cyan)
        end
      end
    end
  end
end
