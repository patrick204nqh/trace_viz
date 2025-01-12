# frozen_string_literal: true

require_relative "../base_renderer"
require "trace_viz/builders/diagram/sequence_builder"
require "trace_viz/syntax/mermaid/sequence_syntax"
require "trace_viz/formatters/diagram/sequence_formatter"

module TraceViz
  module Renderers
    module Diagram
      class SequenceRenderer < BaseRenderer
        def initialize(collector, context)
          super(collector, context)

          @builder = Builders::Diagram::SequenceBuilder.new(collector)
          @formatter = Formatters::Diagram::SequenceFormatter.new
          @syntax = Syntax::Mermaid::SequenceSyntax.new(formatter: @formatter)
          @diagram = builder.build
        end

        def to_lines
          [
            header_line,
            *participant_lines,
            *message_lines,
          ]
        end

        private

        attr_reader :builder, :diagram, :syntax

        def header_line
          NodeLine.new(nil, syntax.header)
        end

        def participant_lines
          diagram.participants.map do |participant|
            NodeLine.new(nil, syntax.participant(participant))
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
