# frozen_string_literal: true

require "trace_viz/utils/format_utils"

module TraceViz
  module Formatters
    module Helpers
      module SourceHelper
        def source_location_representation
          return unless config.source_location[:show]

          truncated_path = Utils::FormatUtils.truncate_value(
            trace_data.path,
            config.source_location[:truncate_length],
          )
          "at #{truncated_path}:#{trace_data.line_number}"
        end
      end
    end
  end
end
