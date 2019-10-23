class Resistor
  def initialize(*colors)
    @tolerance_color = colors.last
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
