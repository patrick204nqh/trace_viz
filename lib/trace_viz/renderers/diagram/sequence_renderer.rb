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
            *render_boxes,
            *render_messages,
          ]
        end

        private

        attr_reader :builder, :diagram, :syntax

        def header_line
          NodeLine.new(nil, syntax.header)
        end

        def render_boxes
          diagram.boxes.flat_map { |box| render_box(box) }
        end

        def render_messages
          diagram.messages.map { |message| NodeLine.new(nil, syntax.message(message)) }
        end

        def render_box(box)
          [
            NodeLine.new(nil, syntax.box_start(box)),
            *render_participants(box),
            NodeLine.new(nil, syntax.box_end(box)),
          ]
        end

        def render_participants(box)
          box.participants.map do |participant|
            NodeLine.new(nil, syntax.participant(participant))
          end
        end
      end
    end
  end
end
