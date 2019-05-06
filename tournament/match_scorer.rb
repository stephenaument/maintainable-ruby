require_relative 'team_stat'

# match scorer base class
class MatchScorer
  attr_reader :match, :teams

  def initialize(match)
    @match = match
  end

  def score(teams)
    teams = teams.dup

    team_stats = match.team_names.map { |name| teams[name] ||= TeamStat.new(name: name) }

    yield *team_stats

    teams
  end
end

# DrawScorer scores a draw
class DrawScorer < MatchScorer
  def score(teams)
    super do |first_team_stat, second_team_stat|
      first_team_stat.add_draw
      second_team_stat.add_draw
    end
  end
end

# LossScorer scores a loss
class LossScorer < MatchScorer
  def score(teams)
    super do |first_team_stat, second_team_stat|
      second_team_stat.add_win
      first_team_stat.add_loss
    end
  end
end

# WinScorer scores a win
class WinScorer < MatchScorer
  def score(teams)
    super do |first_team_stat, second_team_stat|
      first_team_stat.add_win
      second_team_stat.add_loss
    end
  end
end
