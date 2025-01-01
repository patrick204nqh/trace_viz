# frozen_string_literal: true

require_relative "trace_pipeline"
require_relative "steps"

module TraceViz
  module Collectors
    class TracePipelineBuilder
      class << self
        def build
          TracePipeline.new.tap do |pipeline|
            pipeline.add_step(Steps::ValidationStep.new)

            #
            # Those actions require access to the current call,
            # so it needs to be run before current call is updated
            #
            pipeline.add_step(Steps::BuildHierarchyStep.new)
            pipeline.add_step(Steps::LinkingStep.new)

            pipeline.add_step(Steps::AssignDepthForCallStep.new)
            pipeline.add_step(Steps::AssignDepthForReturnStep.new)
            pipeline.add_step(Steps::HiddenStep.new)
          end
        end
      end
    end
  end
end
