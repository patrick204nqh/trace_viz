# frozen_string_literal: true

require "trace_viz/models/message"
require_relative "../base_extractor"

module TraceViz
  module Extractors
    module Diagram
      class MessageExtractor < BaseExtractor
        def initialize(collector, participants)
          super(collector)

          @participants_map = participants.each_with_object({}) do |p, memo|
            memo[p.name] = p
          end
        end

        def extract
          root = data
          root.children.flat_map { |child| traverse(child, nil) }
        end

        private

        def participant_for(name)
          @participants_map[name.to_s]
        end

        def traverse(node, caller_trace)
          messages = []
          trace = node.data

          current_participant = participant_for(trace.klass)

          if caller_trace && participant_for(caller_trace.klass) != current_participant
            messages << call_message(caller_trace, trace)
          end

          messages << loop_start(trace) if loop?(trace)

          messages << build_message(trace)

          messages << activate(trace) if node_has_children?(trace)

          node.children.each do |child|
            messages.concat(traverse(child, trace))
          end

          messages << deactivate(trace) if node_has_children?(trace)

          messages << loop_end(trace) if loop?(trace)

          if caller_trace && participant_for(caller_trace.klass) != current_participant
            messages << return_message(trace, caller_trace)
          end

          messages.compact
        end

        # -- Domain-level message-building methods --

        def loop_start(trace)
          Models::Message.new(
            type: :loop_start,
            from: nil,
            to: nil,
            content: "#{trace.count} calls",
          )
        end

        def loop_end(trace)
          Models::Message.new(
            type: :loop_end,
            from: nil,
            to: nil,
            content: "",
          )
        end

        def activate(trace)
          Models::Message.new(
            type: :activate,
            from: nil,
            to: participant_for(trace.klass),
            content: "",
          )
        end

        def deactivate(trace)
          Models::Message.new(
            type: :deactivate,
            from: nil,
            to: participant_for(trace.klass),
            content: "",
          )
        end

        def build_message(trace)
          Models::Message.new(
            type: :call,
            from: participant_for(trace.klass),
            to: participant_for(trace.klass),
            content: trace.action,
          )
        end

        def call_message(from_trace, to_trace)
          Models::Message.new(
            type: :call,
            from: participant_for(from_trace.klass),
            to: participant_for(to_trace.klass),
            content: "Calling #{to_trace.klass}#{format_params(to_trace.params)}",
          )
        end

        def return_message(from_trace, to_trace)
          Models::Message.new(
            type: :return,
            from: participant_for(from_trace.klass),
            to: participant_for(to_trace.klass),
            content: "Returning to #{to_trace.klass}#{format_result(from_trace.result)}",
          )
        end

        # -- Utility for formatting parameters/results --

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

        # -- Helper methods for logic --

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
