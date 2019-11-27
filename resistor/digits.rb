# Translates digit color bands.
class Digits
  COLOR_VALUES = {
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

  attr_reader :colors

  def initialize(colors)
    @colors = colors

    Validator.new(self, COLOR_VALUES.keys).validate!
  end

  def value
    @value ||= values.join.to_i
  end

  def values
    @colors.map &COLOR_VALUES
  end

  # Validates digit color bands
  class Validator
    attr_reader :digits, :known_colors

    def initialize(digits, known_colors=[])
      @digits = digits
      @known_colors = known_colors
    end

    def invalid_digit_colors
      digits.colors - known_colors
    end

    def message
      "invalid digit color(s) given: #{invalid_digit_colors.join(', ')}"
    end

    def validate!
      raise ArgumentError, message if invalid_digit_colors.any?
    end
  end
end
