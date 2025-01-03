# frozen_string_literal: true

require_relative "defaults/config"
require_relative "defaults/colors"
require_relative "defaults/themes"
require_relative "defaults/actions"

module TraceViz
  module Defaults
    @action_colors = Actions::COLORS.dup

    class << self
      attr_reader :action_colors

      def action_colors=(new_colors)
        @action_colors.merge!(new_colors)
      end
    end
  end
end
