require_relative './digits'
require_relative './multiplier'
require_relative './resistor_validator'
require_relative './tolerance'
require_relative './value'

class Resistor
  attr_reader :colors, :digit_colors, :multiplier_color, :tolerance_color

  def initialize(*colors)
    *@digit_colors, @multiplier_color, @tolerance_color = @colors = colors

    ResistorValidator.new(self).validate!
    @digits = Digits.new(@digit_colors)
    @multiplier = Multiplier.new(@multiplier_color)
    @tolerance = Tolerance.new(@tolerance_color)
    @value = Value.new(digits: digits, multiplier: multiplier)
  end

  class << self
    def human_value(*colors)
      new(*colors).human_value
    end

    def value(*colors)
      new(*colors).value
    end
  end

  def digits
    @digits.value
  end

  def human_multiplier
    @multiplier.to_s
  end

  def human_value
    @value.to_s
  end

  def multiplier
    @multiplier.value
  end

  def tolerance
    @tolerance.to_s
  end

  def to_s
    "#{human_value} #{tolerance}"
  end

  def value
    @value.value
  end
end
