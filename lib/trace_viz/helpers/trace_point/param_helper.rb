# frozen_string_literal: true

module TraceViz
  module Helpers
    module TracePoint
      module ParamHelper
        IGNORED_VARIABLES = [
          "__ENCODING__", "__LINE__", "__FILE__",
        ].freeze

        IGNORED_METHODS = [
          "initialize",
          "inspect",
          "object_id",
          "to_s",
          "class",
          "method",
          "instance_variable_get",
          "instance_variable_set",
          "instance_variables",
          "public_methods",
          "private_methods",
          "protected_methods",
          "respond_to?",
          "send",
        ].freeze

        def extract_params(binding, method_name)
          method = fetch_method_via_instance_method(binding, method_name)
          return {} unless method

          extract_parameters_from_signature(method.parameters, binding)
        end

        def fetch_method_via_instance_method(binding, method_name)
          klass_instance = safe_eval(binding, "self")
          return unless klass_instance

          klass = klass_instance.class
          klass.instance_method(method_name)
        rescue StandardError
          # TraceViz.logger.error("Failed to fetch method #{method_name}: #{e.message}")
          nil
        end

        def extract_parameters_from_signature(parameters, binding)
          parameters.each_with_object({}) do |(_, name), hash|
            next unless name
            next if should_ignore_parameter?(name)

            hash[name] = safe_local_variable_get(binding, name)
          end
        end

        def safe_local_variable_get(binding, name)
          binding.local_variable_get(name)
        rescue NameError
          # class_name = safe_eval(binding, "self.class") || "unknown class"
          # TraceViz.logger.error("Failed to get local variable '#{name}' in #{class_name}: #{e.message}")
          nil
        end

        def safe_eval(binding, expression)
          binding.eval(expression)
        rescue StandardError => e
          TraceViz.logger.error("Failed to eval expression #{expression}: #{e.message}")
          nil
        end

        def should_ignore_parameter?(parameter_name)
          parameter_name_str = parameter_name.to_s
          return true if should_ignore_variable?(parameter_name_str)
          return true if should_ignore_method?(parameter_name_str)
          return true if splat_parameter?(parameter_name_str)
          return true if placeholder_parameter?(parameter_name_str)

          false
        end

        def should_ignore_variable?(variable_name_str)
          IGNORED_VARIABLES.include?(variable_name_str)
        end

        def should_ignore_method?(method_name_str)
          IGNORED_METHODS.include?(method_name_str)
        end

        def splat_parameter?(parameter_name_str)
          parameter_name_str.include?("*")
        end

        def placeholder_parameter?(parameter_name_str)
          parameter_name_str.start_with?("_")
        end
      end
    end
  end
end
