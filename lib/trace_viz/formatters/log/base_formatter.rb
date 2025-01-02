# frozen_string_literal: true

require_relative "../trace_data_formatter"

module TraceViz
  module Formatters
    module Log
      class BaseFormatter < TraceDataFormatter
        include Helpers::Log::ColorHelper
      end
    end
  end
end
