require_relative './match'
require_relative './team_stat'

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
