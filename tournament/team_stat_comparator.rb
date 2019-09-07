# A TeamStatComparator compares two TeamStat objects for
# sorting. It first tries to place them in descending
# point order. If the points are the same, it falls back
# to alphabetical sorting by name.
#
# Like the usual `<=>` method on an object,
# TeamStatComparater.compare returns -1, 0, or 1.
class TeamStatComparator
  attr_reader :team_stats

  def initialize(*team_stats)
    @team_stats = team_stats
  end

  class << self
    def compare(*team_stats)
      new(*team_stats).compare
    end
  end

  def compare
    point_score || name_score
  end

  def name_score
    team_stats.first.name <=> team_stats.last.name
  end

  def point_score
    raw_point_score unless raw_point_score == 0
  end

  def raw_point_score
    team_stats.last.points <=> team_stats.first.points
  end
end
