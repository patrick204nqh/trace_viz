# frozen_string_literal: true

module TraceViz
  module Loggers
    class LogLevelResolver
      LOG_LEVELS = {
        call: :start,
        return: :finish,
      }.freeze

      class << self
        def resolve(trace_data)
          LOG_LEVELS[trace_data.event] || :info
        end
      end
    end
  end
end
