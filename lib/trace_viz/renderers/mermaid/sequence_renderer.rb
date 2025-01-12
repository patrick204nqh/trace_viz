# frozen_string_literal: true

require_relative "../base_renderer"
require_relative "syntax/sequence_syntax"
require "trace_viz/diagram_builders/mermaid/sequence_builder"

module TraceViz
  module Renderers
    module Mermaid
      class SequenceRenderer < BaseRenderer
        def initialize(collector, context)
          super
          @syntax = Syntax::SequenceSyntax.new
        end

        def to_lines
          lines = []

          lines.push(header_line)
          lines.concat(participant_lines)
          lines.concat(message_lines)

          lines
        end

        private

        attr_reader :syntax

        def data
          @data ||= DiagramBuilders::Mermaid::SequenceBuilder.new(collector).build
        end

        def header_line
          NodeLine.new(nil, syntax.header)
        end

        def participant_lines
          participants = data[:participants]
          participants.map do |klass, alias_name|
            NodeLine.new(nil, build_participant_line(alias_name, klass))
          end
        end

        def message_lines
          messages = data[:messages]
          messages.map do |message|
            NodeLine.new(nil, build_message_line(message))
          end
        end

        def build_participant_line(alias_name, klass)
          "#{indent_level}#{syntax.participant(alias_name, klass)}"
        end

        def build_message_line(message)
          "#{indent_level}#{syntax.message(message[:from], message[:to], message[:message])}"
        end

        def indent_level
          tab_size = 2
          " " * tab_size
        end
      end
    end
  end
end
