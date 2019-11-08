require_relative './digits'
require_relative './multiplier'

class Value
  def initialize(digit_colors:, multiplier_color:)
    @digits = Digits.new digit_colors
    @multiplier = Multiplier.new multiplier_color
  end

  def digits
    @digits.value
  end

  def human_multiplier
    @multiplier.to_s
  end

  def multiplier
    @multiplier.value
  end

  def value
    digits * multiplier * 1_000
  end

  def to_s
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
end
