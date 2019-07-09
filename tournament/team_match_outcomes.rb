# A collection of `TeamMatchOutcome` objects
class TeamMatchOutcomes
  attr_reader :outcomes

  def initialize(outcomes=[])
    @outcomes = outcomes
  end

  def draws
    outcomes.count &:draw?
  end

  def losses
    outcomes.count &:loss?
  end

  def matches_played
    outcomes.count
  end

  def points
    outcomes.sum &:points
  end

  def wins
    outcomes.count &:win?
  end

  def +(other_outcomes)
    TeamMatchOutcomes.new(outcomes + other_outcomes.outcomes)
  end

  def <<(other_outcome)
    outcomes << other_outcome
  end
end
