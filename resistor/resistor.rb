require 'forwardable'
require_relative './resistor_validator'
require_relative './tolerance'
require_relative './value'

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
