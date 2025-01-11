# frozen_string_literal: true

require_relative "base_builder"
require_relative "../extractors/participant_extractor"
require_relative "../extractors/message_extractor"

module TraceViz
  module DiagramBuilders
    module Mermaid
      class SequenceBuilder < BaseBuilder
        def build
          participant_extractor = Extractors::ParticipantExtractor.new(collector)
          participants = participant_extractor.extract

          message_extractor = Extractors::MessageExtractor.new(collector, participants)
          messages = message_extractor.extract

          {
            participants: participants,
            messages: messages,
          }
        end
      end
    end
  end
end
