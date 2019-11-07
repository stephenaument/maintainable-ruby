class Digits
  attr_reader :colors

  def initialize(colors)
    @colors = colors

    known_digit_colors = %w[black brown red orange yellow green blue violet gray grey white]
    invalid_digit_colors = @colors - known_digit_colors
    raise ArgumentError, "invalid digit color(s) given: #{invalid_digit_colors.join(', ')}" if invalid_digit_colors.any?
  end

  def value
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

    @colors.map do |color|
      digit_values[color]
    end.join.to_i
  end
end
