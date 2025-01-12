# frozen_string_literal: true

module TraceViz
  module Models
    class Message
      attr_reader :type, :from, :to, :content

      def initialize(type:, from:, to:, content:)
        @type = type
        @from = from
        @to = to
        @content = content
      end
    end
  end
end
