# frozen_string_literal: true

require_relative "trace_pipeline"
require_relative "steps/validation_step"
require_relative "steps/assign_depth_step"
require_relative "steps/linking_step"
require_relative "steps/hidden_step"

module TraceViz
  module Collectors
    class TracePipelineBuilder
      class << self
        def build
          TracePipeline.new.tap do |pipeline|
            pipeline.add_step(Steps::ValidationStep.new)

            #
            # This action will link trace data to current call,
            # so it needs to be run before current call is updated
            #
            pipeline.add_step(Steps::LinkingStep.new)

            pipeline.add_step(Steps::AssignDepthStep.new)
            pipeline.add_step(Steps::HiddenStep.new)
          end
        end
      end
    end
  end
end
