class Digits
  attr_reader :colors

  def initialize(colors)
    @colors = colors
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
