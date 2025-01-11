# frozen_string_literal: true

require "trace_viz/helpers/config_helper"

module TraceViz
  module Transformers
    TransformedNode = Struct.new(:data, :children)

    class BaseTransformer
      include Helpers::ConfigHelper

      def initialize(collector)
        @collector = collector
      end

      def transform
        raise NotImplementedError
      end

      private

      attr_reader :collector

      def data
        raise NotImplementedError
      end
    end
  end
end
