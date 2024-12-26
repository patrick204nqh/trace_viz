# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Exporters
    module Formatters
      module Yaml
        class MethodCallFormatter < BaseFormatter
          def format
            [
              indent_representation,
              method_name_representation,
              source_location_representation,
              params_representation,
            ].compact.join(" ")
          end
        end
      end
    end
  end
end
