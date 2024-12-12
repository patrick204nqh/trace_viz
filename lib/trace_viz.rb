# frozen_string_literal: true

require "trace_viz/version"
require "trace_viz/core/tracer"

module TraceViz
  class Error < StandardError; end

  class << self
    def trace(&block)
      Core::Tracer.new.trace(&block)
    end
  end
end
