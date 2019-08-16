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
