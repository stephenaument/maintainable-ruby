require_relative './team_stat'

# match scorer base class
#
# Expects match.teams to return an array containing
# exactly 2 team names.
class MatchScorer
  attr_reader :match, :team_stats

  def initialize(match)
    @match = match
    @team_stats = match.teams.map { |name| TeamStat.new name: name }
    score
  end

  # Implemented in child classes. Marks the team_stats win/lose/draw according
  # to the match outcome.
  def score
  end
end

# DrawScorer scores a draw
class DrawScorer < MatchScorer
  def score
    team_stats.first.add_draw
    team_stats.last.add_draw
  end
end

# LossScorer scores a loss
class LossScorer < MatchScorer
  def score
    team_stats.first.add_loss
    team_stats.last.add_win
  end
end

# WinScorer scores a win
class WinScorer < MatchScorer
  def score
    team_stats.first.add_win
    team_stats.last.add_loss
  end
end
