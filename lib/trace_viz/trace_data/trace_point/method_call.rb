# frozen_string_literal: true

require_relative "base"

module TraceViz
  module TraceData
    module TracePoint
      class MethodCall < Base
        attr_reader :params

        DISPLAY_MODES = {
          name_and_value: ->(name, value) { "#{name}: #{value}" },
          name_only: ->(name, _) { name.to_s },
          value_only: ->(_, value) { value },
        }.freeze

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
          method = binding.eval("method(:#{id})")
          method.parameters.each_with_object({}) do |(_, name), hash|
            next unless name

            value = binding.local_variable_get(name)
            hash[name] = format_param(name, value)
          end
        end

        def format_param(name, value)
          mode = config.param_display_mode
          formatter = DISPLAY_MODES[mode]
          formatter.call(name, value)
        end
      end
    end
  end
end
