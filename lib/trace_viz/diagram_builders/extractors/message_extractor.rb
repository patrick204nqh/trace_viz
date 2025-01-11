# frozen_string_literal: true

require "trace_viz/utils/hierarchy_flattener"
require_relative "base_extractor"

module TraceViz
  module DiagramBuilders
    module Extractors
      class MessageExtractor < BaseExtractor
        def initialize(collector, participants)
          super(collector)
          @participants = participants
        end

        def extract
          nodes_without_root.map { |node| build_message(node.data) }
        end

        private

        attr_reader :participants

        def data
          @data ||= Transformers::SummaryTransformer.new(collector).transform
        end

        def nodes
          @nodes ||= Utils::HierarchyFlattener.flatten(data)
        end

        def nodes_without_root
          nodes.drop(1)
        end

        def build_message(data)
          {
            from: participants[data.klass],
            to: participants[data.klass],
            message: data.action,
          }
        end
      end
    end
  end
end
