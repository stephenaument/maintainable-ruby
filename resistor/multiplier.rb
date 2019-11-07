class Multiplier
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
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

    human_multiplier_values[@color]
  end

  def value
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

    multiplier_values[@color]
  end
end
