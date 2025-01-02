# frozen_string_literal: true

require_relative "base_transformer"
require "trace_viz/exporters/formatters/method_call_formatter"
require "trace_viz/exporters/formatters/method_return_formatter"

module TraceViz
  module Exporters
    module Transformers
      class TextTransformer < BaseTransformer
        def transform
          collection.map do |trace_data|
            format_item(trace_data)
          end
        end

        def format_item(trace_data)
          case trace_data.event
          when :call
            Formatters::MethodCallFormatter.new.call(trace_data)
          when :return
            Formatters::MethodReturnFormatter.new.call(trace_data)
          end
        end
      end
    end
  end
end
