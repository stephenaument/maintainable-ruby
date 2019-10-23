class Resistor
  def initialize(*colors)
    @tolerance_color = colors.last
    @multiplier_color = colors[-2]
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
end
