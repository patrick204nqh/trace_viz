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
          Models::Diagram.new.tap do |diagram|
            add_boxes_to(diagram)
            add_messages_to(diagram)
          end
        end

        private

        attr_reader :collector

        def add_boxes_to(diagram)
          boxes.each { |box| diagram.add_box(box) }
        end

        def add_messages_to(diagram)
          messages.each { |message| diagram.add_message(message) }
        end

        def boxes
          @boxes ||= Extractors::Diagram::BoxExtractor.new(collector).extract
        end

        def participants
          @participants ||= boxes.flat_map(&:participants)
        end

        def messages
          @messages ||= Extractors::Diagram::MessageExtractor.new(collector, participants).extract
        end
      end
    end
  end
end
