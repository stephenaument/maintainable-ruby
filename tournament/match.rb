require_relative 'match_scorer'

# A representation of a match
class Match
  WIN  = 'win'
  LOSS = 'loss'
  DRAW = 'draw'

  attr_reader :team1, :team2, :result, :match_scorer

  def initialize(outcome)
    @team1, @team2, @result = outcome.split(';')
    @match_scorer = get_match_scorer
  end

  def get_match_scorer
    case result.chomp
    when WIN
      return WinScorer.new self
    when LOSS
      return LossScorer.new self
    when DRAW
      return DrawScorer.new self
    end
  end

  def team_names
    [team1, team2]
  end

  def team_stats(team_stats)
    match_scorer.score team_stats
  end
end
