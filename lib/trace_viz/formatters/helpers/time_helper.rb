# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module TimeHelper
        def execution_time_representation(trace_data)
          return unless config.execution[:show_time] && trace_data.duration

          format("in %.6fms", trace_data.duration)
        end
      end
    end
  end
end
