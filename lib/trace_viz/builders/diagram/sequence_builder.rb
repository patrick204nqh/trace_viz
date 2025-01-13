# frozen_string_literal: true

require "trace_viz/models/diagram"
require "trace_viz/extractors/diagram/participant_extractor"
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

          participants = Extractors::Diagram::ParticipantExtractor.new(collector).extract
          messages = Extractors::Diagram::MessageExtractor.new(collector, participants).extract

          participants.each { |p| diagram.add_participant(p) }
          messages.each { |m| diagram.add_message(m) }

          diagram
        end

        private

        attr_reader :collector
      end
    end
  end
end
