# frozen_string_literal: true

require_relative "base_formatter"

module TraceViz
  module Exporters
    module Formatters
      module Yaml
        class MethodReturnFormatter < BaseFormatter
          def call
            [
              indent_representation,
              method_name_representation,
              result_representation,
              source_location_representation,
              execution_time_representation,
            ].compact.join(" ")
          end
        end
      end
    end
  end
end
