class CommitEligibility
  attr_reader :eligibility

  def initialize(eligibility)
    @eligibility = eligibility
  end

  def call
    eligibility.each do |team_id, player_ids|
      Team.find(team_id).set_eligibility(player_ids.keys)
    end
  end
end