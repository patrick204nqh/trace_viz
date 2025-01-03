# frozen_string_literal: true

require "trace_viz/helpers"

module TraceViz
  module Formatters
    class BaseFormatter
      include Helpers::ConfigHelper

      def call
        raise NotImplementedError
      end
    end
  end
end
