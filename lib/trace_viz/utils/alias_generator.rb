# frozen_string_literal: true

module TraceViz
  module Utils
    class AliasGenerator
      COMPONENT_DELIMITER = "::"
      ALIAS_DELIMITER = "_"

      class << self
        #
        # Generates a unique alias for a given name and ensures it doesn't conflict
        # with existing aliases.
        #
        def generate(name:, assigned_aliases:)
          raise ArgumentError, "name cannot be nil" if name.nil?

          # Break the name into components and extract initials
          alias_candidate = extract_initials(name.to_s)

          # Ensure the alias is unique
          unique_alias = ensure_unique_alias(
            candidate: alias_candidate,
            assigned_aliases: assigned_aliases,
            original_name: name,
          )

          # Record the alias in the map
          assigned_aliases[name] = unique_alias
          unique_alias
        end

        private

        #
        # Extracts initials from a namespaced string
        #
        def extract_initials(full_name)
          parts = full_name.split(COMPONENT_DELIMITER)
          initials = parts.map { |part| part.scan(/[A-Z]/).join }
          initials.join(ALIAS_DELIMITER)
        end

        #
        # Ensures the alias is unique by appending a counter if necessary
        #
        def ensure_unique_alias(candidate:, assigned_aliases:, original_name:)
          unique_alias = candidate
          counter = 1
          while assigned_aliases.value?(unique_alias)
            unique_alias = "#{candidate}#{ALIAS_DELIMITER}#{counter}"
            counter += 1
          end
          unique_alias
        end
      end
    end
  end
end
