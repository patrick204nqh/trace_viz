# frozen_string_literal: true

require_relative "helpers/indent_helper"
require_relative "helpers/depth_helper"
require_relative "helpers/time_helper"
require_relative "helpers/params_helper"
require_relative "helpers/source_helper"
require_relative "helpers/result_helper"
require_relative "helpers/method_details_helper"

module TraceViz
  module Formatters
    class BaseFormatter
      def format
        raise NotImplementedError
      end
    end
  end
end
