# frozen_string_literal: true

require_relative "base_filter"

module TraceViz
  module Collectors
    module Filters
      class ExcludeRailsFrameworkFilter < BaseFilter
        RAILS_MODULES = [
          "ActiveSupport",
          "ActiveModel",
          "ActiveRecord",
          "ActionPack",
          "ActionController",
          "ActionView",
          "ActionMailer",
          "ActiveJob",
          "ActionCable",
          "ActionDispatch",
          "ActiveStorage",
          "ActionMailbox",
          "ActionText",
          "Rails",
        ].freeze

        def apply?(trace_data)
          !rails_related?(trace_data.klass)
        end

        private

        def rails_related?(klass)
          RAILS_MODULES.any? { |mod| klass.to_s.start_with?(mod) }
        end
      end
    end
  end
end
