require 'forwardable'
require_relative './digits'
require_relative './multiplier'

# Translates digit and multiplier color bands.
class Value
  extend Forwardable

  MILLIS_MULTIPLIER = 1_000
  UNITS = %w[mΩ Ω kΩ MΩ GΩ]
  VALUE_FORMAT = '%g%s'
  VALUES_PER_UNIT = 1_000

  def initialize(digit_colors:, multiplier_color:)
    @digits = Digits.new digit_colors
    @multiplier = Multiplier.new multiplier_color
  end

  def_delegator :@digits, :value, :digits
  def_delegator :@multiplier, :to_s, :human_multiplier
  def_delegator :@multiplier, :value, :multiplier

  def exponent
    Math.log(value, VALUES_PER_UNIT).floor
  end

  def to_s
    VALUE_FORMAT % [unit_scaled_value, unit]
  end

  def unit
    UNITS[exponent]
  end

  def unit_scale_divisor
    VALUES_PER_UNIT ** exponent
  end

  def unit_scaled_value
    value.to_f / unit_scale_divisor
  end

  def value
    digits * multiplier * MILLIS_MULTIPLIER
  end
end
