# frozen_string_literal: true

require "trace_viz/helpers"

module TraceViz
  module Collectors
    module Filters
      class BaseFilter
        include Helpers::ConfigHelper

        def apply?(trace_data)
          raise NotImplementedError
        end
      end
    end
  end
end
