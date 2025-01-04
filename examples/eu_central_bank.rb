$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'eu_central_bank'
require 'i18n'
require 'trace_viz'

# Fix the locale issue
I18n.config.available_locales = [:en]
I18n.locale = :en

TraceViz.trace(
  general: {
    tab_size: 1,
    mode: :summary,
    show_indent: true,
    show_depth: true,
    max_display_depth: 5,
    show_method_name: true,
  },
  params: {
    show: true,
    mode: :name_only,
    # truncate_length: 10
  },
  result: {
    show: true,
    truncate_length: 15,
  },
  source_location: {
    show: true,
    truncate_length: 50,
  },
  execution: {
    show_time: true,
    show_trace_events: [:call, :return],
  },
  log: {
    runtime: false,
    post_collection: true,
    stats: true
  },
  filters: [
    :exclude_internal_call,
    :exclude_default_classes,
    # include_classes: {
    #   classes: [EuCentralBank],
    # },
    # exclude_classes: {
    #   classes: ['Gem']
    # },
    exclude_gems: {
      gems: ['nokogiri', 'money', 'i18n']
    }
  ],
  export: {
    enabled: true,
    format: :txt,
    overwrite: true,
  }
) do
  # Create a new instance of the EuCentralBank
  bank = EuCentralBank.new

  # Trace the update of exchange rates
  bank.update_rates

  # Trace conversion of currency
  result = bank.exchange(50, 'USD', 'EUR')
  puts "Converted amount: #{result}"
end