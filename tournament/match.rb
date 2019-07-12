class Match

  attr_reader :teams, :outcome

  def initialize(result)
    *@teams, @outcome = result.chomp.split(';')
  end

  def team_stats
    first_team, second_team = *teams

    team_stats = []

    team_stats << TeamStat.new(name: first_team)
    team_stats << TeamStat.new(name: second_team)
    team_stats.first.matches_played += 1
    team_stats.last.matches_played += 1

    if outcome == 'win'
      team_stats.first.wins += 1
      team_stats.first.points += 3
      team_stats.last.losses += 1
    elsif outcome == 'loss'
      team_stats.last.wins += 1
      team_stats.last.points += 3
      team_stats.first.losses += 1
    else
      team_stats.first.draws += 1
      team_stats.first.points += 1
      team_stats.last.draws += 1
      team_stats.last.points += 1
    end

    team_stats
  end
end
