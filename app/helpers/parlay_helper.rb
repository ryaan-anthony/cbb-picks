module ParlayHelper
  def parlays
    @parlay.picks.combination(@parlay.num_teams).to_a.shuffle.each_with_object([]) do |parlay, memo|
      middle_matches = select_matches(parlay, @parlay.middle_teams)
      bottom_matches = select_matches(parlay, @parlay.bottom_teams)

      next if count_occurrences(middle_matches, memo).any? { |count| count >= @parlay.middle_occurrences }
      next if count_occurrences(bottom_matches, memo).any? { |count| count >= @parlay.bottom_occurrences }
      next if count_occurrences(parlay, memo).any? { |count| count >= @parlay.max_occurrences }

      # Select this parlay
      memo << parlay
    end
  end

  def pick_occurrences
    (@parlay.top_teams.count * @parlay.max_occurrences) +
      (@parlay.middle_teams.count * @parlay.middle_occurrences) +
      (@parlay.bottom_teams.count * @parlay.bottom_occurrences)
  end

  def weight_class(team)
    if @parlay.top_teams.include? team
      'top_teams'
    elsif @parlay.middle_teams.include? team
      'middle_teams'
    else
      'bottom_teams'
    end
  end

  private

  # @return [Array<Symbol>]
  def select_matches(parlay, picks)
    parlay.select do |team|
      picks.include? team
    end
  end

  # @param [Array<Symbol>] parlay
  # @param [Array<Array<Symbol>>] bets
  # @return [Array<Integer>]
  def count_occurrences(parlay, bets)
    parlay.map do |team|
      bets.count { |bet| bet.include? team }
    end
  end
end
