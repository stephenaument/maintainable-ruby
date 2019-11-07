require_relative './digits'
require_relative './resistor_validator'
require_relative './tolerance'

class Resistor
  attr_reader :colors, :digit_colors, :multiplier_color, :tolerance_color

  def initialize(*colors)
    *@digit_colors, @multiplier_color, @tolerance_color = @colors = colors

    ResistorValidator.new(self).validate!
    @digits = Digits.new(@digit_colors)
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
    @digits.digits
  end

  def human_multiplier
    human_multiplier_values = {
      'black'  => '1Ω',
      'brown'  => '10Ω',
      'red'    => '100Ω',
      'orange' => '1kΩ',
      'yellow' => '10kΩ',
      'green'  => '100kΩ',
      'blue'   => '1MΩ',
      'violet' => '10MΩ',
      'gray'   => '100MΩ',
      'grey'   => '100MΩ',
      'white'  => '1GΩ',
      'gold'   => '0.1Ω',
      'silver' => '0.01Ω',
    }

    human_multiplier_values[@multiplier_color]
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
    multiplier_values = {
      'black'  => 1,
      'brown'  => 10,
      'red'    => 100,
      'orange' => 1_000,
      'yellow' => 10_000,
      'green'  => 100_000,
      'blue'   => 1_000_000,
      'violet' => 10_000_000,
      'grey'   => 100_000_000,
      'gray'   => 100_000_000,
      'white'  => 1_000_000_000,
      'gold'   => 0.1,
      'silver' => 0.01,
    }

    multiplier_values[@multiplier_color]
  end

  def tolerance
    @tolerance.tolerance
  end

  def to_s
    "#{human_value} #{tolerance}"
  end

  def value
    digits * multiplier * 1_000
  end
end
