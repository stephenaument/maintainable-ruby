require_relative './single_color_validator'

class Tolerance
  COLOR_VALUES = {
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

  attr_reader :color

  def initialize(color)
    @color = color

    SingleColorValidator.new(self, COLOR_VALUES.keys).validate!
  end

  def to_s
    COLOR_VALUES[@color]
  end
end
