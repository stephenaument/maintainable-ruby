require_relative './match_scorer'

# Returns an appropriate match scorer based on the
# match result.
#
# The `MatchScorerFactory` follows a class naming convention
# in which the result is capitalized and concatenated to 'Scorer'.
#
# For instance, if the result is 'draw', the equivalent scorer class
# is called `DrawScorer`.
#
# If a new possible match result is added to the system, this factory
# does not need to change, but the appropriate scorer class must be
# added.
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
    Object.const_get("#{match.result.capitalize}Scorer")
  end
end
