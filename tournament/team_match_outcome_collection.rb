class TeamMatchOutcomeCollection
  attr_reader :team_match_outcomes

  def initialize(team_match_outcomes=[])
    @team_match_outcomes = team_match_outcomes
  end

  def draws
    team_match_outcomes.count &:draw?
  end

  def losses
    team_match_outcomes.count &:loss?
  end

  def matches_played
    team_match_outcomes.count
  end

  def points
    team_match_outcomes.sum &:points
  end

  def wins
    team_match_outcomes.count &:win?
  end

  def +(other_collection)
    TeamMatchOutcomeCollection.new(
      team_match_outcomes + other_collection.team_match_outcomes
    )
  end

  def <<(team_match_outcome)
    team_match_outcomes << team_match_outcome
  end
end
