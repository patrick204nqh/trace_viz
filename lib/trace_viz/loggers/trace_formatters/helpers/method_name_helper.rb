# frozen_string_literal: true

module TraceViz
  module Loggers
    module TraceFormatters
      module Helpers
        module MethodNameHelper
          def format_method_name(trace_data, config)
            return unless config.general[:show_method_name]

            "#{format_class_name(trace_data)}#{format_action_name(trace_data)}"
          end

          private

          def format_class_name(trace_data)
            klass = colorize(trace_data.klass, :light_green)
            method_sign = colorize("#", :blue)
            [klass, method_sign].join
          end

          def format_action_name(trace_data)
            colorize(trace_data.action, :bold, :light_cyan)
          end
        end
      end
    end
  end
end
