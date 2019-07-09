require_relative './match_scorer_factory'

# A representation of a match
class Match
  attr_reader :teams, :result, :scorer

  def initialize(outcome)
    *@teams, @result = parse_outcome outcome
    @scorer = MatchScorerFactory.scorer self
  end

  def team_stats
    scorer.team_stats
  end

private

  def parse_outcome(outcome)
    outcome.chomp.split(';')
  end
end
