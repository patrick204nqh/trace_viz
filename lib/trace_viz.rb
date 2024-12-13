# frozen_string_literal: true

require "trace_viz/version"
require "trace_viz/configuration"
require "trace_viz/core"

module TraceViz
  class Error < StandardError; end

  class << self
    def trace(**options, &block)
      Core::Tracer.new.trace(**options, &block)
    end
  end
end
