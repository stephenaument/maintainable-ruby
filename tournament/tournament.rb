require 'ostruct'
require_relative './team_stat'

class Tournament
  HEADER = "Team                           | MP |  W |  D |  L |  P\n"

  attr_reader :results

  def initialize(results)
    @results = results.strip
  end

  class << self
    def tally(results)
      new(results).tally
    end
  end

  def matches
    results.lines.map { |result| Match.new result }
  end

  def tally
    "#{HEADER}#{team_stats.sort.join}"
  end

  def team_stats
    team_stats = {}

    matches.each do |match|
      first_team, second_team, outcome = *match.teams, match.outcome

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

class Match
  attr_reader :teams, :outcome

  def initialize(result)
    *@teams, @outcome = result.chomp.split(';')
  end
end
