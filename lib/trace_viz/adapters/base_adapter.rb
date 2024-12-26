# frozen_string_literal: true

module TraceViz
  module Adapters
    class BaseAdapter
      def trace
        raise NotImplementedError
      end
    end
  end
end
