# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module MethodDetailsHelper
        def method_name_representation(trace_data)
          return unless config.general[:show_method_name]

          "#{trace_data.klass}##{trace_data.action}"
        end
      end
    end
  end
end
