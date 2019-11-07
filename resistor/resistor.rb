require_relative './digits'
require_relative './multiplier'
require_relative './resistor_validator'
require_relative './tolerance'

class Resistor
  attr_reader :colors, :digit_colors, :multiplier_color, :tolerance_color

  def initialize(*colors)
    *@digit_colors, @multiplier_color, @tolerance_color = @colors = colors

    ResistorValidator.new(self).validate!
    @digits = Digits.new(@digit_colors)
    @multiplier = Multiplier.new(@multiplier_color)
    @tolerance = Tolerance.new(@tolerance_color)
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
    unit = case value
           when (0..999)
             'mΩ'
           when (1_000..999_999)
             'Ω'
           when (1_000_000..999_999_999)
             'kΩ'
           when (1_000_000_000..999_999_999_999)
             'MΩ'
           else
             'GΩ'
           end

    unit_scale_divisor = case value
                         when (0..999)
                           1
                         when (1_000..999_999)
                           1_000
                         when (1_000_000..999_999_999)
                           1_000_000
                         when (1_000_000_000..999_999_999_999)
                           1_000_000_000
                         else
                           1_000_000_000_000
                         end

    unit_scaled_value = value.to_f / unit_scale_divisor

    '%g%s' % [unit_scaled_value, unit]
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
    digits * multiplier * 1_000
  end
end
