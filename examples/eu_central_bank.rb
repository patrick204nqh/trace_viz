$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'eu_central_bank'
require 'i18n'
require 'trace_viz'

# Fix the locale issue
I18n.config.available_locales = [:en]
I18n.locale = :en

TraceViz.trace(
  general: {
    tab_size: 4,
    show_indent: true,
    show_depth: true,
    max_display_depth: 3,
    show_method_name: true,
  },
  params: {
    show: true,
    mode: :name_only
  },
  execution: {
    show_time: true,
    show_trace_events: [:call],
  },
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
