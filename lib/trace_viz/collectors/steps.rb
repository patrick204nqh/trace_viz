# frozen_string_literal: true

require_relative "steps/validation_step"
require_relative "steps/build_hierarchy_step"
require_relative "steps/linking_step"
require_relative "steps/assign_depth_for_call_step"
require_relative "steps/assign_depth_for_return_step"
require_relative "steps/hidden_step"

module TraceViz
  module Collectors
    module Steps
    end
  end
end
