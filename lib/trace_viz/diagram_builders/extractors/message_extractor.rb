# frozen_string_literal: true

module TraceViz
  module DiagramBuilders
    module Extractors
      class MessageExtractor < BaseExtractor
        def initialize(collector, participants)
          super(collector)
          @participants = participants
        end

        def extract
          root = data

          root.children.flat_map { |child| traverse(child, nil) }
        end

        private

        attr_reader :participants

        def traverse(node, caller_trace)
          messages = []
          trace = node.data
          current_participant = participants[trace.klass]

          if caller_trace && participants[caller_trace.klass] != current_participant
            messages << call_message(caller_trace, trace)
          end

          messages << loop_start(trace) if loop?(trace)
          messages << build_message(trace)
          messages << activate(trace) if node_has_children?(trace)

          # Recursively process child nodes
          node.children.each do |child|
            messages.concat(traverse(child, trace))
          end

          messages << deactivate(trace) if node_has_children?(trace)
          messages << loop_end(trace) if loop?(trace)

          if caller_trace && participants[caller_trace.klass] != current_participant
            messages << return_message(trace, caller_trace)
          end

          messages.compact
        end

        def loop_start(trace)
          { type: :loop_start, message: "#{trace.count} calls" }
        end

        def loop_end(trace)
          { type: :loop_end }
        end

        def activate(trace)
          { type: :activate, participant: participants[trace.klass] }
        end

        def deactivate(trace)
          { type: :deactivate, participant: participants[trace.klass] }
        end

        def build_message(trace)
          {
            type: :message,
            from: participants[trace.klass],
            to: participants[trace.klass],
            message: trace.action,
          }
        end

        def call_message(from_trace, to_trace)
          {
            type: :message,
            from: participants[from_trace.klass],
            to: participants[to_trace.klass],
            message: "Calling #{to_trace.klass}#{format_params(to_trace.params)}",
          }
        end

        def return_message(from_trace, to_trace)
          {
            type: :return_message,
            from: participants[from_trace.klass],
            to: participants[to_trace.klass],
            message: "Returning to #{to_trace.klass}#{format_result(from_trace.result)}",
          }
        end

        def format_params(params)
          return "" if params.nil? || params.empty?

          summarized = params.map { |key, value| "#{sanitize(key)}: #{sanitize(value, 10)}" }
          " [#{summarized.join(", ")}]"
        end

        def format_result(result)
          return "" if result.nil?

          " with result: #{sanitize(result, 15)}"
        end

        def sanitize(value, max_length = 50)
          str = value.to_s
          sanitized = str.gsub(/[<>#&{}]/, "").gsub('"', "'")
          sanitized.length > max_length ? "#{sanitized[0...max_length]}..." : sanitized
        end

        def truncate(value, max_length)
          sanitize(value, max_length)
        end

        def loop?(trace)
          trace.key == :summary_group
        end

        def node_has_children?(trace)
          trace.children.any?
        end

        def data
          @data ||= Transformers::SummaryTransformer.new(collector).transform
        end
      end
    end
  end
end
