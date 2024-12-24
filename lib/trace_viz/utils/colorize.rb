# frozen_string_literal: true

module TraceViz
  module Utils
    module Colorize
      class << self
        def colorize(text, color)
          return text unless text

          "#{Defaults.colors[color]}#{text}#{Defaults.colors[:reset]}"
        end
      end
    end
  end
end
