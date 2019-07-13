class MatchScorerFactory
  attr_reader :match

  def initialize(match)
    @match = match
  end

  class << self
    def scorer(match)
      new(match).scorer
    end
  end

  def scorer
    scorer_class.new match
  end

  def scorer_class
    Object.const_get scorer_classname
  end

  def scorer_classname
    "#{match.outcome.capitalize}Scorer"
  end
end
