# frozen_string_literal: true

class ComplexClass
  def initialize(data)
    @data = data
  end

  def process_data
    validate_data && perform_operations_and_log
  end

  private

  # Method to invoke two operations at the same level
  def perform_operations_and_log
    perform_operations
    log_results
  end

  def validate_data
    data_present? && data_format_valid? && data_within_bounds?
  end

  def data_present?
    !@data.nil?
  end

  def data_format_valid?
    @data.is_a?(Hash)
  end

  def data_within_bounds?
    @data[:value].between?(1, 100)
  end

  def perform_operations
    calculate_result
  end

  def calculate_result
    intermediate_value = multiply_by_factor(@data[:value], 10)
    subtract_offset(intermediate_value, 5)
  end

  def multiply_by_factor(value, factor)
    value * factor
  end

  def subtract_offset(value, offset)
    value - offset
  end

  def log_results
    puts "Result logged successfully."
    true
  end
end
