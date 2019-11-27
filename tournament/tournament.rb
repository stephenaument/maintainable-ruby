require 'ostruct'

class Tournament
  HEADER = "Team                           | MP |  W |  D |  L |  P\n"
  attr_reader :games

  def initialize(games)
    @games = games
  end

  class << self
    def tally(games)
      new(games).tally
    end
  end

  def tally
    team_stats = {}

    games.each_line do |game|
      next if game.chomp!.empty?

      first_team, second_team, outcome = game.split(';')

      team_stats[first_team] ||= OpenStruct.new(name: first_team, matches_played: 0, wins: 0, draws: 0, losses: 0, points: 0)
      team_stats[second_team] ||= OpenStruct.new(name: second_team, matches_played: 0, wins: 0, draws: 0, losses: 0, points: 0)
      team_stats[first_team].matches_played += 1
      team_stats[second_team].matches_played += 1

      if outcome == 'win'
        team_stats[first_team].wins += 1
        team_stats[first_team].points += 3
        team_stats[second_team].losses += 1
      elsif outcome == 'loss'
        team_stats[second_team].wins += 1
        team_stats[second_team].points += 3
        team_stats[first_team].losses += 1
      else
        team_stats[first_team].draws += 1
        team_stats[first_team].points += 1
        team_stats[second_team].draws += 1
        team_stats[second_team].points += 1
      end
    end

    # "#{HEADER}#{team_stats.sort.join}"

    "#{HEADER}#{team_stats.values.sort do |a,b|
      cmp = b.points <=> a.points
      cmp == 0 ? a.name <=> b.name : cmp
    end.map do |team|
      "%-31s| %2s | %2s | %2s | %2s | %2s\n" % [team.name, team.matches_played, team.wins, team.draws, team.losses, team.points]
    end.join}"
  end
end
