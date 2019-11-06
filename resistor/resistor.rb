class Resistor
  def initialize(*colors)
    *@digit_colors, @multiplier_color, @tolerance_color = colors

    raise ArgumentError, 'given fewer than 4 colors' if colors.length < 4
    raise ArgumentError, 'given more than 5 colors' if colors.length > 5
    known_digit_colors = %w[black brown red orange yellow green blue violet gray grey white]
    invalid_digit_colors = @digit_colors - known_digit_colors
    raise ArgumentError, "invalid digit color(s) given: #{invalid_digit_colors.join(', ')}" if invalid_digit_colors.any?
    known_multiplier_colors = %w[black brown red orange yellow green blue violet gray grey white gold silver]
    raise ArgumentError, "invalid multiplier color given: #{@multiplier_color}" unless known_multiplier_colors.include? @multiplier_color
    known_tolerance_colors = %w[brown red green blue violet gray grey gold silver]
    raise ArgumentError, "invalid tolerance color given: #{@tolerance_color}" unless known_tolerance_colors.include? @tolerance_color
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
    digit_values = {
      'black'  => 0,
      'brown'  => 1,
      'red'    => 2,
      'orange' => 3,
      'yellow' => 4,
      'green'  => 5,
      'blue'   => 6,
      'violet' => 7,
      'gray'   => 8,
      'grey'   => 8,
      'white'  => 9,
    }

    @digit_colors.map do |color|
      digit_values[color]
    end.join.to_i
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
    color_values = {
      'brown'  => '±1%',
      'red'    => '±2%',
      'green'  => '±0.5%',
      'blue'   => '±0.25%',
      'violet' => '±0.1%',
      'grey'   => '±0.05%',
      'gray'   => '±0.05%',
      'gold'   => '±5%',
      'silver' => '±10%',
    }

    color_values[@tolerance_color]
  end

  def to_s
    "#{human_value} #{tolerance}"
  end

  def value
    digits * multiplier * 1_000
  end
end
