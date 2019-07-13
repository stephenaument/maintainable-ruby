class MatchScorer
  attr_reader :team_stats

  def initialize(match)
    @team_stats = match.teams.map { |name| TeamStat.new name: name, matches_played: 1 }
    score
  end

  def score
    raise NotImplementedError
  end
end

class DrawScorer < MatchScorer
  def score
    team_stats.first.draws += 1
    team_stats.first.points += 1
    team_stats.last.draws += 1
    team_stats.last.points += 1
  end
end

class LossScorer < MatchScorer
  def score
    team_stats.last.wins += 1
    team_stats.last.points += 3
    team_stats.first.losses += 1
  end
end

class WinScorer < MatchScorer
  def score
    team_stats.first.wins += 1
    team_stats.first.points += 3
    team_stats.last.losses += 1
  end
end
