# frozen_string_literal: true

require_relative "base"

module TraceViz
  module TraceData
    module TracePoint
      class MethodCall < Base
        attr_reader :params, :method_return

        def initialize(trace_point)
          super(trace_point)

          populate_params
        end

        def link(method_return)
          @method_return = method_return
        end

        private

        def populate_params
          @params = extract_params(trace_point.binding)
        end

        def extract_params(binding)
          method = binding.eval("method(:#{action})")
          method.parameters.each_with_object({}) do |(_, name), hash|
            next unless name
            next if name.to_s.include?("*") # Skip invalid or special variable names

            value = safe_local_variable_get(binding, name)
            hash[name] = value
          end
        end

        def safe_local_variable_get(binding, name)
          binding.local_variable_defined?(name) ? binding.local_variable_get(name) : nil
        rescue NameError
          nil
        end
      end
    end
  end
end
