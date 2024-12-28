# frozen_string_literal: true

require "trace_viz/formatters/trace_data_formatter"
require_relative "helpers/color_helper"
require_relative "helpers/depth_helper"
require_relative "helpers/method_name_helper"

module TraceViz
  module Loggers
    module TraceFormatters
      class BaseFormatter < TraceViz::Formatters::TraceDataFormatter
        include Helpers::ColorHelper
        include Helpers::DepthHelper
        include Helpers::MethodNameHelper
      end
    end
  end
end
