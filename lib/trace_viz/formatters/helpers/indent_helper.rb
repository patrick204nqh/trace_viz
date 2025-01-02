# frozen_string_literal: true

module TraceViz
  module Formatters
    module Helpers
      module IndentHelper
        def indent_representation(trace_data)
          return unless config.general[:show_indent] && config.general[:show_depth]

          " " * (config.general[:tab_size] * trace_data.depth)
        end
      end
    end
  end
end
