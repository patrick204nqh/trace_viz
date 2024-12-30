# frozen_string_literal: true

require "trace_viz/helpers/tracking_helper"
require "trace_viz/helpers/config_helper"

module TraceViz
  module Collectors
    module Steps
      class BaseStep
        include Helpers::TrackingHelper
        include Helpers::ConfigHelper

        def initialize
          @logger = TraceViz.logger
        end

        def call
          raise NotImplementedError
        end

        private

        attr_reader :logger
      end
    end
  end
end
