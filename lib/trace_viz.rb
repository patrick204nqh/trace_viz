# frozen_string_literal: true

# For detailed documentation, please refer to https://www.rubydoc.info/gems/trace_viz

require "trace_viz/version"
require "trace_viz/errors"
require "trace_viz/core"

module TraceViz
  class << self
    def trace(**options, &block)
      Core::Tracer.new.trace(**options, &block)
    end
  end
end
