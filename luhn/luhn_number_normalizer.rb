# The LuhnNumberNormalizer is responsible for taking an input
# string and rendering it processable by the LuhnValidator class.
# To do this, it makes a best effort to convert the input to a String
# and remove any spaces.
class LuhnNumberNormalizer
  attr_reader :input

  def initialize(input)
    @input = input
  end

  class << self
    def normalize(input)
      new(input).normalize
    end
  end

  def normalize
    String(input).gsub(/\s/, '')
  end
end

