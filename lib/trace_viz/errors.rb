# frozen_string_literal: true

module TraceViz
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class AdapterError < Error; end
  class ContextError < Error; end
end
