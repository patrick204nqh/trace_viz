# frozen_string_literal: true

require "trace_viz/context/config_context"
require "trace_viz/context/tracking_context"

module TraceViz
  module Context
    class Registry
      CONTEXTS = {
        config: ConfigContext,
        tracking: TrackingContext,
      }.freeze

      class << self
        # Builds a hash of context objects based on the provided contexts hash.
        #
        # @param [Hash] contexts A hash where the keys are context keys and the values are options for each context.
        #   Example:
        #     {
        #       context_key1: { option1: 'value1', option2: 'value2' },
        #       context_key2: { option1: 'value3', option2: 'value4' }
        #     }
        #
        # @return [Hash] A hash where the keys are context keys and the values are instantiated context objects.
        #
        # @raise [ArgumentError] If a context key is not found in the CONTEXTS hash.
        def build(contexts)
          contexts.each_with_object({}) do |(context_key, options), result|
            klass = CONTEXTS.fetch(context_key)

            result[context_key] = klass.new(**(options || {}))
          end
        end
      end
    end
  end
end
