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

          populate_params
        end

        private

        def populate_params
          @params = extract_params(trace_point.binding)
        end

        def extract_params(binding)
          method = binding.eval("method(:#{id})")
          method.parameters.each_with_object({}) do |(_, name), hash|
            next unless name
            next if name.to_s.include?("*") # Skip invalid or special variable names

            value = safe_local_variable_get(binding, name)
            hash[name] = format_param(name, value)
          end
        end

        def safe_local_variable_get(binding, name)
          binding.local_variable_defined?(name) ? binding.local_variable_get(name) : nil
        rescue NameError
          nil
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
