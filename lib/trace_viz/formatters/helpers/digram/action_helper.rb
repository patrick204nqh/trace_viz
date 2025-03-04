# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module Diagram
        module ActionHelper
          def action_representation(trace_data)
            return unless config.general[:show_method_name]

            trace_data.action
          end
        end
      end
    end
  end
end
