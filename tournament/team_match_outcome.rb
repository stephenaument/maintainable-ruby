require_relative './team_match_outcomes'

# A representation of a match outcome for a team
#
# An outcome is one of :win, :loss, :draw
class TeamMatchOutcome
  attr_reader :outcome, :points

  def initialize(outcome, points=0)
    @outcome = outcome
    @points = points
  end

  def draw?
    outcome == :draw
  end

  def loss?
    outcome == :loss
  end

  def win?
    outcome == :win
  end
end
