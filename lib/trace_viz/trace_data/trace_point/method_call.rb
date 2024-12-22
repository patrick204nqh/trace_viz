# frozen_string_literal: true

require_relative "base"

module TraceViz
  module TraceData
    module TracePoint
      class MethodCall < Base
        attr_reader :params

        def initialize(trace_point)
          super(trace_point)

          cache_params
          increment_depth
        end

        private

        def cache_params
          @params = extract_params(trace_point.binding)
        end

        def extract_params(binding)
          binding.local_variables.each_with_object({}) do |var, hash|
            hash[var] = binding.local_variable_get(var)
          end
        end
      end
    end
  end
end
