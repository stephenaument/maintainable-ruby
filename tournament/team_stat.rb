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
