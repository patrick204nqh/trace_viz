# frozen_string_literal: true

require_relative "../base_renderer"
require_relative "syntax/sequence_syntax"
require "trace_viz/diagram_builders/mermaid/sequence_builder"

module TraceViz
  module Renderers
    module Mermaid
      class SequenceRenderer < BaseRenderer
        def initialize(collector)
          super(collector, context: nil)
          @syntax = Syntax::SequenceSyntax.new
        end

        def to_lines
          lines = [NodeLine.new(nil, syntax.header)]

          participants = data[:participants]
          participants.each do |klass, alias_name|
            lines << NodeLine.new(nil, syntax.participant(alias_name, klass))
          end

          messages = data[:messages]
          messages.each do |message|
            lines << NodeLine.new(nil, syntax.message(message[:from], message[:to], message[:message]))
          end

          lines
        end

        private

        attr_reader :syntax

        def data
          @data ||= DiagramBuilders::Mermaid::SequenceBuilder.new(collector).build
        end
      end
    end
  end
end
