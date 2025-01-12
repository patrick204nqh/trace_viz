# frozen_string_literal: true

require_relative "../base_renderer"
require "trace_viz/diagram_builders/mermaid/sequence_converter"
require "trace_viz/diagram_builders/mermaid/sequence_builder"
require "trace_viz/diagram_builders/mermaid/sequence_processor"

module TraceViz
  module Renderers
    module Mermaid
      class SequenceRenderer < BaseRenderer
        def initialize(collector, context)
          super(collector, context)
          @builder = DiagramBuilders::Mermaid::SequenceBuilder.new
          @processor = DiagramBuilders::Mermaid::SequenceProcessor.new(@builder, collector)
          @converter = DiagramBuilders::Mermaid::SequenceConverter.new

          process_and_convert
        end

        def to_lines
          [
            header_line,
            *participant_lines,
            *message_lines,
          ]
        end

        private

        attr_reader :builder, :processor, :converter

        def process_and_convert
          @processed_data = processor.process
          @converted_data = converter.convert(@processed_data)
        end

        def header_line
          NodeLine.new(nil, @converted_data.header)
        end

        def participant_lines
          map_to_node_lines(@converted_data.participants)
        end

        def message_lines
          map_to_node_lines(@converted_data.messages)
        end

        def map_to_node_lines(data)
          data.map { |item| NodeLine.new(nil, item) }
        end
      end
    end
  end
end
