# An individual team tournament statistic set
class TeamStat
  WIN_POINTS = 3
  DRAW_POINTS = 1

  attr_reader :name, :matches_played, :wins, :draws, :losses, :points

  def initialize(name:)
    @name = name
    @matches_played = 0
    @wins = 0
    @draws = 0
    @losses = 0
    @points = 0
  end

  def add_draw
    @matches_played += 1
    @draws  += 1
    @points += DRAW_POINTS
  end

  def add_loss
    @matches_played += 1
    @losses += 1
  end

  def add_win
    @matches_played += 1
    @wins   += 1
    @points += WIN_POINTS
  end

  def field_values
    [name, matches_played, wins, draws, losses, points]
  end

  def to_str
    Tournament::TALLY_ROW_FORMAT % field_values
  end

  def <=>(otherStat)
    comparison = otherStat.points <=> points
    comparison == 0 ? name <=> otherStat.name : comparison
  end
end

