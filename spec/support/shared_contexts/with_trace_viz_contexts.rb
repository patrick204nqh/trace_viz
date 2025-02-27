# frozen_string_literal: true

RSpec.shared_context("with TraceViz contexts") do |contexts = {}|
  before do
    default_contexts = { config: {}, tracking: {} }
    TraceViz::Context::Manager.enter_contexts(default_contexts.merge(contexts))
  end

  after do
    TraceViz::Context::Manager.exit_contexts(:config, :tracking)
  end
end
