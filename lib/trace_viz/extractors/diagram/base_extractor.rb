# frozen_string_literal: true

require "trace_viz/transformers/summary_transformer"
require_relative "../base_extractor"

module TraceViz
  module Extractors
    module Diagram
      class BaseExtractor < BaseExtractor
        private

        def data
          @data ||= Transformers::SummaryTransformer.new(collector).transform
        end
      end
    end
  end
end
