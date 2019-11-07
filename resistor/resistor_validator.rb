class ResistorValidator
  MAX_LENGTH = 5
  MIN_LENGTH = 4

  attr_reader :resistor

  def initialize(resistor)
    @resistor = resistor
  end

  def too_long?
    resistor.colors.length > MAX_LENGTH
  end

  def too_long_message
    'given more than 5 colors'
  end

  def too_short?
    resistor.colors.length < MIN_LENGTH
  end

  def too_short_message
    'given fewer than 4 colors'
  end

  def validate!
    validate_not_too_short!
    validate_not_too_long!
  end

  def validate_not_too_long!
    raise ArgumentError, too_long_message if too_long?
  end

  def validate_not_too_short!
    raise ArgumentError, too_short_message if too_short?
  end
end
