# frozen_string_literal: true

require_relative "processors/message_processor"
require_relative "base_extractor"

module TraceViz
  module Extractors
    module Diagram
      class MessageExtractor < BaseExtractor
        def initialize(collector, participants)
          super(collector)

          @node_processor = Processors::MessageProcessor.new(participants)
        end

        def extract
          root = data
          root.children.flat_map { |child| @node_processor.process_node(child) }
        end
      end
    end
  end
end
