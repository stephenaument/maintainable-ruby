require_relative './match'
require_relative './team_stat'

# Representation of a Tournament scoreboard
#
# Match results are provided as lined input, with each line specifying two team
# names and an outcome, each field delimited by a semicolon, like this:
#
#     Tournament.tally results
#
# where results is:
#
#     Allegoric Alaskans;Blithering Badgers;win
#     Devastating Donkeys;Courageous Californians;draw
#     Devastating Donkeys;Allegoric Alaskans;win
#     Courageous Californians;Blithering Badgers;loss
#     Blithering Badgers;Devastating Donkeys;loss
#     Allegoric Allegoric; Courageous Californians;win
#
# A win earns 3 points, a draw 1 point, a loss 0 points
#
# The results are tallied and returned as a table like this:
#
#     Team                           | MP |  W |  D |  L |  P
#     Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
#     Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
#     Blithering Badgers             |  3 |  1 |  0 |  2 |  3
#     Courageous Californians        |  3 |  0 |  1 |  2 |  1
#
# The columns represent the team name, matches played, wins, draws, losses, and points.
class Tournament
  TALLY_ROW_FORMAT = "%-31s| %2s | %2s | %2s | %2s | %2s\n"
  TALLY_HEADER_VALUES = %w(Team MP W D L P)
  TALLY_HEADER = TALLY_ROW_FORMAT % TALLY_HEADER_VALUES

  attr_reader :results

  def initialize(results)
    @results = normalize results
  end

  class << self
    def tally(results)
      new(results).tally
    end
  end

  def matches
    results.lines.map { |result| Match.new(result) }
  end

  def tally
    "#{TALLY_HEADER}#{team_stat_totals.sort.join}"
  end

  def team_stats
    matches
      .map(&:team_stats)
      .flatten
  end

  def team_stat_totals
    team_stats
      .group_by(&:name)
      .map { |name, team_stats| team_stats.sum(TeamStat.new(name: name)) }
  end

private

  def normalize(results)
    String(results).strip
  end
end
