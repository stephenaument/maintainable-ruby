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
    if match.outcome == 'win'
      WinScorer.new(match)
    elsif match.outcome == 'loss'
      LossScorer.new(match)
    else
      DrawScorer.new(match)
    end
  end
end
