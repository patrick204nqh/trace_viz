# frozen_string_literal: true

require "trace_viz/helpers/config_helper"
require_relative "base_matcher"

module TraceViz
  module Collectors
    module Matchers
      class WithinDepthMatcher
        include Helpers::ConfigHelper

        def matches?(depth)
          depth <= max_depth
        end

        private

        def max_depth
          config.general[:max_display_depth]
        end

        private :config
      end
    end
  end
end
