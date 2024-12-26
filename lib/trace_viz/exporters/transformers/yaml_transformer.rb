# frozen_string_literal: true

require_relative "base_transformer"
require "trace_viz/exporters/formatters/yaml/method_call_formatter"
require "trace_viz/exporters/formatters/yaml/method_return_formatter"

module TraceViz
  module Exporters
    module Transformers
      class YamlTransformer < BaseTransformer
        def transform
          collection.map do |trace_data|
            format_item(trace_data)
          end
        end

        def format_item(trace_data)
          case trace_data.event
          when :call
            Formatters::Yaml::MethodCallFormatter.new(trace_data).format
          when :return
            Formatters::Yaml::MethodReturnFormatter.new(trace_data).format
          end
        end
      end
    end
  end
end
