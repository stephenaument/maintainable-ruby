class Tolerance
  attr_reader :color

  def initialize(color)
    @color = color

    known_tolerance_colors = %w[brown red green blue violet gray grey gold silver]
    raise ArgumentError, "invalid tolerance color given: #{@color}" unless known_tolerance_colors.include? @color
  end

  def to_s
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

    color_values[@color]
  end
end
