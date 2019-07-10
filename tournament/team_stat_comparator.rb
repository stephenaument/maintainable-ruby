# A TeamStatComparator compares two TeamStat objects for
# sorting. It first tries to place them in decending
# point order. If the points are the same, it falls back
# to alphabetical sorting by name.
#
# Like the usual `<=>` method on an object, TeamStatComparator
# returns -1, 0, or 1.
class TeamStatComparator
  attr_reader :stats

  def initialize(*stats)
    @stats = stats
  end

  class << self
    def compare(*stats)
      new(*stats).compare
    end
  end

  def compare
    point_score || name_score
  end

  def name_score
    stats.first.name <=> stats.last.name
  end

  def point_score
    raw_point_score unless raw_point_score == 0
  end

  def raw_point_score
    stats.last.points <=> stats.first.points
  end
end
