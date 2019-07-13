require_relative './match_scorer'
require_relative './match_scorer_factory'

class Match

  attr_reader :teams, :outcome

  def initialize(result)
    *@teams, @outcome = parse result
  end

  def scorer
    MatchScorerFactory.scorer self
  end

  def team_stats
    scorer.team_stats
  end

private

  def parse(result)
    result.chomp.split(';')
  end
end
