# frozen_string_literal: true

module TraceViz
  class Logger
    COLORS = {
      reset: "\e[0m",
      info: "\e[34m",
      success: "\e[32m",
      error: "\e[31m",
      warn: "\e[33m",
      start: "\e[36m",
      finish: "\e[35m",
    }.freeze

    EMOJIS = {
      info: "ℹ️",
      success: "✅",
      error: "❌",
      warn: "⚠️",
      start: "🚀",
      finish: "🏁",
    }.freeze

    LEVELS = [:info, :success, :error, :warn].freeze

    def initialize(output: $stdout)
      @output = output
    end

    def info(message)
      log(:info, message)
    end

    def success(message)
      log(:success, message)
    end

    def error(message)
      log(:error, message)
    end

    def warn(message)
      log(:warn, message)
    end

    def start(message)
      log(:start, message)
    end

    def finish(message)
      log(:finish, message)
    end

    private

    def log(level, message)
      return unless LEVELS.include?(level)

      color = COLORS[level] || COLORS[:info]
      emoji = EMOJIS[level] || EMOJIS[:info]
      formatted_message = "#{color}#{emoji} [#{level.to_s.upcase}]#{COLORS[:reset]} #{message}"
      @output.puts(formatted_message)
    end
  end
end
