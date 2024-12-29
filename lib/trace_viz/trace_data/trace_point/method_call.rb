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

        def duration
          return 0 unless method_return

          method_return.timestamp - timestamp
        end

        private

        def populate_params
          @params = extract_params(trace_point.binding, action)
        end

        def extract_params(binding, method_name)
          method = fetch_method_via_instance_method(binding, method_name)
          return {} unless method

          extract_parameters_from_signature(method.parameters, binding)
        rescue StandardError => e
          log_error("Failed to extract parameters for method #{method_name}: #{e.message}")
          {}
        end

        def fetch_method_via_instance_method(binding, method_name)
          klass_instance = binding.eval("self")
          klass = klass_instance.class
          begin
            klass.instance_method(method_name)
          rescue
            nil
          end
        end

        def extract_parameters_from_signature(parameters, binding)
          parameters.each_with_object({}) do |(_, name), hash|
            next unless name
            next if name.to_s.include?("*") # Skip invalid or special variable names

            value = safe_local_variable_get(binding, name)
            hash[name] = value
          end
        end

        def safe_local_variable_get(binding, name)
          binding.local_variable_get(name)
        rescue NameError
          nil
        end

        def log_error(message)
          TraceViz.logger.error(message)
        end
      end
    end
  end
end
