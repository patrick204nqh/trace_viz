# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Exporters
    module Formatters
      class MethodCallFormatter < BaseFormatter
        def format
          [
            indent_if_enabled,
            depth_if_enabled,
            method_name_if_enabled,
            source_location_if_enabled,
            params_if_enabled,
          ].compact.join(" ")
        end
      end
    end
  end
end
