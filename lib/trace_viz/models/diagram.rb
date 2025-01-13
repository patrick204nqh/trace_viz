# frozen_string_literal: true

module TraceViz
  module Models
    class Diagram
      attr_reader :participants, :messages

      def initialize
        @participants = []
        @messages = []
      end

      def add_participant(participant)
        @participants << participant unless @participants.include?(participant)
      end

      def add_message(message)
        @messages << message
      end
    end
  end
end
