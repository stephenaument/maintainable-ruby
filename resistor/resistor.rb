require 'forwardable'
require_relative './resistor_validator'
require_relative './tolerance'
require_relative './value'

# Translates the color bands on a resistor. Can return the value of the resistor
# in milliohms as an integer, the raw value of the digits represented by the
# first 2 or 3 bands, the value as a human-readable string, the multiplier, and
# the tolerance. It will also be able to render itself as a human-readable
# string, "22kΩ ±0.5%", where 22k is the product of the value '22' and the
# multiplier '1k', and ±0.5% is the tolerance.
#
# The colors are given as 4 or 5 strings.
#
#   Restistor.new('green', 'blue', 'yellow', 'gold').value #> 560_000_000
#
#   Resistor.human_value 'red', 'orange', 'violet', 'black', 'brown' #> '237Ω'
class Resistor
  extend Forwardable
  attr_reader :colors

  def initialize(*colors)
    *digit_colors, multiplier_color, tolerance_color = @colors = colors

    ResistorValidator.new(self).validate!

    @tolerance = Tolerance.new(tolerance_color)
    @value = Value.new(digit_colors: digit_colors, multiplier_color: multiplier_color)
  end

  def_delegators :@value, :digits, :human_multiplier, :multiplier, :value
  def_delegator :@value, :to_s, :human_value
  def_delegator :@tolerance, :to_s, :tolerance

  class << self
    def human_value(*colors)
      new(*colors).human_value
    end

    def value(*colors)
      new(*colors).value
    end
  end

  def to_s
    "#{human_value} #{tolerance}"
  end
end
