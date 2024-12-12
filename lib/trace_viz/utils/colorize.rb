# frozen_string_literal: true

module TraceViz
  module Utils
    module Colorize
      ANSI_COLORS = {
        reset: "\e[0m",
        black: "\e[30m",
        red: "\e[31m",
        green: "\e[32m",
        yellow: "\e[33m",
        blue: "\e[34m",
        magenta: "\e[35m",
        cyan: "\e[36m",
        light_gray: "\e[37m",
        dark_gray: "\e[90m",
        light_red: "\e[91m",
        light_green: "\e[92m",
        light_yellow: "\e[93m",
        light_blue: "\e[94m",
        light_magenta: "\e[95m",
        light_cyan: "\e[96m",
        white: "\e[97m",
      }.freeze

      class << self
        def colorize(text, color)
          return text unless text

          "#{ANSI_COLORS[color]}#{text}#{ANSI_COLORS[:reset]}"
        end
      end
    end
  end
end
