# frozen_string_literal: true

require "trace_viz/helpers"

module TraceViz
  module Formatters
    class BaseFormatter
      include Helpers::ConfigHelper

      # Format the data to a line
      def call
        raise NotImplementedError
      end
    end
  end
end
