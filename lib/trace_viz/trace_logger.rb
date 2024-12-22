# frozen_string_literal: true

require "trace_viz/formatters/log_builder"

module TraceViz
  class TraceLogger
    LOG_LEVELS = {
      call: :start,
      return: :finish,
    }.freeze

    class << self
      def log(trace_data)
        new.log(trace_data)
      end
    end

    def log(trace_data)
      return unless should_log?(trace_data)

      formatted_message = build_log_message(trace_data)
      log_level = LOG_LEVELS[trace_data.event] || :info
      TraceViz.logger.send(log_level, formatted_message)
    end

    private

    def build_log_message(trace_data)
      Formatters::LogBuilder.new(trace_data).build
    end

    def should_log?(trace_data)
      return false if trace_data.nil?

      trace_data.config.show_trace_events.include?(trace_data.event)
    end
  end
end
