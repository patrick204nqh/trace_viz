# frozen_string_literal: true

require "trace_viz/formatters/diagram/sequence/message_formatter"
require "trace_viz/builders/diagram/message_builder"

module TraceViz
  module Extractors
    module Diagram
      module Processors
        class SequenceNodeProcessor
          def initialize(participants)
            @formatter = Formatters::Diagram::Sequence::MessageFormatter.new
            @message_builder = Builders::Diagram::MessageBuilder.new(@formatter, participants)
          end

          def process_node(node, caller_node = nil)
            trace = node.data
            caller_trace = caller_node&.data

            [].tap do |messages|
              # Handle participant transitions
              messages << @message_builder.build_call_message(
                caller_trace,
                trace,
              ) if caller_trace

              # Process the current node
              messages << handle_loop_start(trace)
              messages << handle_internal_message(trace)
              messages << handle_activation(trace)
              messages.concat(process_children(node))
              messages << handle_deactivation(trace)
              messages << handle_loop_end(trace)

              # Update the current node after processing
              messages << @message_builder.build_return_message(
                trace,
                caller_trace,
              ) if caller_trace
            end.compact
          end

          private

          def handle_loop_start(trace)
            return unless loop?(trace)

            @message_builder.build_loop_start_message(trace)
          end

          def handle_internal_message(trace)
            @message_builder.build_internal_message(trace)
          end

          def handle_activation(trace)
            return unless node_has_children?(trace)

            @message_builder.build_activate_message(trace)
          end

          def handle_deactivation(trace)
            return unless node_has_children?(trace)

            @message_builder.build_deactivate_message(trace)
          end

          def handle_loop_end(trace)
            return unless loop?(trace)

            @message_builder.build_loop_end_message
          end

          def process_children(node)
            node.children.flat_map { |child| process_node(child, node) }
          end

          def loop?(trace)
            trace.key == :summary_group
          end

          def node_has_children?(trace)
            trace.children.any?
          end
        end
      end
    end
  end
end
