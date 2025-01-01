# frozen_string_literal: true

require "trace_viz/traits"
require_relative "base"

module TraceViz
  module TraceData
    class Node < Base
      include Traits::Hierarchical
    end
  end
end
