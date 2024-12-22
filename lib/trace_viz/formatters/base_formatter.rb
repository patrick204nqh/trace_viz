# frozen_string_literal: true

require "trace_viz/utils/colorize"

module TraceViz
  module Formatters
    class BaseFormatter
      def initialize(trace_data)
        @trace_data = trace_data
        @config = @trace_data.config
      end

      def format
        raise NotImplementedError
      end

      private

      attr_reader :trace_data, :config

      def colorize(text, color_key)
        Utils::Colorize.colorize(text, color_key)
      end
    end
  end
end
