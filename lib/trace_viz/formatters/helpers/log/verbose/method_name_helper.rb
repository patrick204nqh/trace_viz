# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module Log
        module Verbose
          module MethodNameHelper
            def format_method_name(trace_data, config)
              return unless config.general[:show_method_name]

              "#{format_class_name(trace_data)}#{format_action_name(trace_data)}"
            end

            private

            def format_class_name(trace_data)
              klass = colorize(trace_data.klass, :trace_method_class)
              method_sign = colorize("#", :trace_method_sign)
              [klass, method_sign].join
            end

            def format_action_name(trace_data)
              colorize(trace_data.action, :trace_method_action)
            end
          end
        end
      end
    end
  end
end
