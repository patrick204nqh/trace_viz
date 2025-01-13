# frozen_string_literal: true

require "trace_viz/transformers/summary_transformer"
require "trace_viz/extractors/diagram/processors/sequence_node_processor"
require_relative "../base_extractor"

module TraceViz
  module Extractors
    module Diagram
      class MessageExtractor < BaseExtractor
        def initialize(collector, participants)
          super(collector)

          @node_processor = Processors::SequenceNodeProcessor.new(participants)
        end

        def extract
          root = data
          root.children.flat_map { |child| @node_processor.process_node(child) }
        end

        private

        def data
          @data ||= Transformers::SummaryTransformer.new(collector).transform
        end
      end
    end
  end
end
