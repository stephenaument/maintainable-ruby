require 'ostruct'

class Tournament
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
    output = "Team                           | MP |  W |  D |  L |  P\n"

    teams = {}

    games.each_line do |game|
      next if game.chomp!.empty?

      first_team, second_team, outcome = game.split(';')

      teams[first_team] ||= OpenStruct.new(name: first_team, matches_played: 0, wins: 0, draws: 0, losses: 0, points: 0)
      teams[second_team] ||= OpenStruct.new(name: second_team, matches_played: 0, wins: 0, draws: 0, losses: 0, points: 0)
      teams[first_team].matches_played += 1
      teams[second_team].matches_played += 1

      if outcome == 'win'
        teams[first_team].wins += 1
        teams[first_team].points += 3
        teams[second_team].losses += 1
      elsif outcome == 'loss'
        teams[second_team].wins += 1
        teams[second_team].points += 3
        teams[first_team].losses += 1
      else
        teams[first_team].draws += 1
        teams[first_team].points += 1
        teams[second_team].draws += 1
        teams[second_team].points += 1
      end
    end

    teams.values.sort do |a,b|
      cmp = b.points <=> a.points
      cmp == 0 ? a.name <=> b.name : cmp
    end.each do |team|
      output += "%-31s| %2s | %2s | %2s | %2s | %2s\n" % [team.name, team.matches_played, team.wins, team.draws, team.losses, team.points]
    end

    output
  end
end
