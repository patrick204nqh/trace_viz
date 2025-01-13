# frozen_string_literal: true

require "trace_viz/models/diagram"
require "trace_viz/extractors/diagram/box_extractor"
require "trace_viz/extractors/diagram/message_extractor"
require_relative "base_builder"

module TraceViz
  module Builders
    module Diagram
      class SequenceBuilder < BaseBuilder
        def initialize(collector)
          super()
          @collector = collector
        end

        def build
          diagram = Models::Diagram.new

          boxes = Extractors::Diagram::BoxExtractor.new(collector).extract
          participants = boxes.flat_map(&:participants)
          messages = Extractors::Diagram::MessageExtractor.new(collector, participants).extract

          boxes.each { |b| diagram.add_box(b) }
          messages.each { |m| diagram.add_message(m) }

          diagram
        end

        private

        attr_reader :collector
      end
    end
  end
end
