# frozen_string_literal: true

module TraceViz
  module Models
    class Diagram
      attr_reader :boxes, :participants, :messages

      def initialize
        @boxes = []
        @participants = []
        @messages = []
      end

      def add_box(box)
        @boxes << box unless @boxes.include?(box)
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
