# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module TimeHelper
        def execution_time_if_enabled
          return unless config.execution[:show_time] && trace_data.duration

          "in #{trace_data.duration}ms"
        end
      end
    end
  end
end
