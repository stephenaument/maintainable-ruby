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
    "#{HEADER}#{team_stats.sort.join}"
  end

  def team_stats
    team_stats = {}

    games.each_line do |game|
      next if game.chomp!.empty?

      first_team, second_team, outcome = game.split(';')

      team_stats[first_team] ||= TeamStat.new(name: first_team)
      team_stats[second_team] ||= TeamStat.new(name: second_team)
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

    team_stats.values
  end
end

class TeamStat
  attr_accessor :name, :matches_played, :wins, :draws, :losses, :points

  def initialize(name:, matches_played: 0, wins: 0, draws: 0, losses: 0, points: 0)
    @name = name
    @matches_played = matches_played
    @wins = wins
    @draws = draws
    @losses = losses
    @points = points
  end

  def <=>(other_team_stat)
    cmp = other_team_stat.points <=> self.points
    cmp == 0 ? self.name <=> other_team_stat.name : cmp
  end

  def to_str
    "%-31s| %2s | %2s | %2s | %2s | %2s\n" % [name, matches_played, wins, draws, losses, points]
  end
end
