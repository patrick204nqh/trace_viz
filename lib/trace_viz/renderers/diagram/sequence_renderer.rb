# frozen_string_literal: true

require_relative "../base_renderer"
require "trace_viz/builders/diagram/sequence_builder"
require "trace_viz/syntax/mermaid/sequence_syntax"

module TraceViz
  module Renderers
    module Diagram
      class SequenceRenderer < BaseRenderer
        def initialize(collector, context)
          super(collector, context)

          @builder = Builders::Diagram::SequenceBuilder.new(collector)
          @syntax = Syntax::Mermaid::SequenceSyntax.new
          @diagram = builder.build
        end

        def to_lines
          [
            header_line,
            *box_lines,
            *message_lines,
          ]
        end

        private

        attr_reader :builder, :diagram, :syntax

        def header_line
          NodeLine.new(nil, syntax.header)
        end

        def box_lines
          diagram.boxes.flat_map do |box|
            [
              NodeLine.new(nil, syntax.box_start(box)),
              *box.participants.map { |participant| NodeLine.new(nil, syntax.participant(participant)) },
              NodeLine.new(nil, syntax.box_end(box)),
            ]
          end
        end

        def message_lines
          diagram.messages.map do |message|
            NodeLine.new(nil, syntax.message(message))
          end
        end
      end
    end
  end
end
