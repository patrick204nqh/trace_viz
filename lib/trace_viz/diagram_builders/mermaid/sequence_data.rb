# frozen_string_literal: true

module TraceViz
  module DiagramBuilders
    module Mermaid
      class SequenceData
        attr_accessor :header, :participants, :messages

        def initialize(header: nil, participants: {}, messages: [])
          @header = header
          @participants = participants
          @messages = messages
        end
      end
    end
  end
end
