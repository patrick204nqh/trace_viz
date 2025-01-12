# frozen_string_literal: true

require_relative "../extractors/participant_extractor"
require_relative "../extractors/message_extractor"

module TraceViz
  module DiagramBuilders
    module Mermaid
      class SequenceProcessor
        def initialize(builder, collector)
          @builder = builder
          @collector = collector
          @participant_extractor = Extractors::ParticipantExtractor.new(collector)
          @message_extractor = Extractors::MessageExtractor.new(collector, builder.participants)
        end

        def process
          process_participants
          process_messages
          builder
        end

        private

        attr_reader :collector, :builder, :participant_extractor, :message_extractor

        def process_participants
          participant_extractor.extract.each do |full_name, alias_name|
            builder.add_participant(alias_name, full_name)
          end
        end

        def process_messages
          message_extractor.extract.each do |message|
            builder.add_message(message)
          end
        end
      end
    end
  end
end
