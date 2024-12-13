# frozen_string_literal: true

module TraceViz
  module Context
    class BaseContext
      attr_reader :options

      def initialize(**options)
        @options = options
      end
    end
  end
end
