# frozen_string_literal: true

module TraceViz
  module Builders
    class BaseBuilder
      def build
        raise NotImplementedError
      end
    end
  end
end
