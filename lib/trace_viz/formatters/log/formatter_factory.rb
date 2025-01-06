# frozen_string_literal: true

require_relative "../base_formatter_factory"
require_relative "method_call_formatter"
require_relative "method_return_formatter"
require_relative "summary_group_formatter"

module TraceViz
  module Formatters
    module Log
      class FormatterFactory < BaseFormatterFactory
        def initialize
          super(
            call: Log::MethodCallFormatter.new,
            return: Log::MethodReturnFormatter.new,
            summary_group: Log::SummaryGroupFormatter.new
          )
        end
      end
    end
  end
end
