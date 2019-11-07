class ResistorValidator
  attr_reader :resistor

  def initialize(resistor)
    @resistor = resistor
  end

  def validate!
    raise ArgumentError, 'given fewer than 4 colors' if resistor.colors.length < 4
    raise ArgumentError, 'given more than 5 colors' if resistor.colors.length > 5
    known_digit_colors = %w[black brown red orange yellow green blue violet gray grey white]
    invalid_digit_colors = resistor.digit_colors - known_digit_colors
    raise ArgumentError, "invalid digit color(s) given: #{invalid_digit_colors.join(', ')}" if invalid_digit_colors.any?
    known_multiplier_colors = %w[black brown red orange yellow green blue violet gray grey white gold silver]
    raise ArgumentError, "invalid multiplier color given: #{resistor.multiplier_color}" unless known_multiplier_colors.include? resistor.multiplier_color
    known_tolerance_colors = %w[brown red green blue violet gray grey gold silver]
    raise ArgumentError, "invalid tolerance color given: #{resistor.tolerance_color}" unless known_tolerance_colors.include? resistor.tolerance_color
  end
end
