# frozen_string_literal: true

require_relative "base_transformer"

module TraceViz
  module Exporters
    module Transformers
      class YamlTransformer < BaseTransformer
        def transform
          deep_transform_keys_and_values(build_hierarchy_hash)
        end

        private

        def build_hierarchy_hash
          hierarchy.root.to_h
        end

        def deep_transform_keys_and_values(data)
          case data
          when Hash
            data.each_with_object({}) do |(key, value), result|
              result[key.to_s] = deep_transform_keys_and_values(value)
            end
          when Array
            data.map { |value| deep_transform_keys_and_values(value) }
          when Symbol
            data.to_s
          else
            data
          end
        end
      end
    end
  end
end
