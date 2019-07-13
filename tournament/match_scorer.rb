class MatchScorer
  attr_reader :team_stats

  def initialize(match)
    @team_stats = match.teams.map { |name| TeamStat.new name: name }
    score
  end

  def score
    raise NotImplementedError
  end
end

class DrawScorer < MatchScorer
  def score
    team_stats.first.add_draw
    team_stats.last.add_draw
  end
end

class LossScorer < MatchScorer
  def score
    team_stats.last.add_win
    team_stats.first.add_loss
  end
end

class WinScorer < MatchScorer
  def score
    team_stats.first.add_win
    team_stats.last.add_loss
  end
end
