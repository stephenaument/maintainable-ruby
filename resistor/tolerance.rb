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

    Validator.new(self).validate!
  end

  def to_s
    COLOR_VALUES[@color]
  end

  class Validator
    attr_reader :tolerance

    def initialize(tolerance)
      @tolerance = tolerance
    end

    def color
      tolerance.color
    end

    def known_colors
      COLOR_VALUES.keys
    end

    def message
      "invalid tolerance color given: #{color}"
    end

    def validate!
      raise ArgumentError, message unless known_colors.include? color
    end
  end
end
