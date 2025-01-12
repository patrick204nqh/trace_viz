# frozen_string_literal: true

module TraceViz
  module Models
    class Participant
      attr_accessor :name, :alias_name

      def initialize(name:, alias_name: nil)
        @name = name
        @alias_name = alias_name
      end

      def ==(other)
        name == other.name
      end
    end
  end
end
