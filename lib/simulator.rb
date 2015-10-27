class Simulator

  def initialize(seating_arrangement)
    raise NotImplementedError
  end

  def verdict
    raise NotImplementedError
  end

  def state
    raise NotImplementedError
  end

  def next
    raise NotImplementedError
  end

end


=begin

# If a person with an opinion has fewer than 2 opinionated neighbours then they stop having an opinion since there are not enough people to argue with.
if examined != :none && neighbours_opinionated.count < 2
  examined = neighbours_opinionated = :none
end

# If a person with an opinion has more than 3 opinionated neighbours then they stop having an opinion since their opinion is drowned out by their neighbours.
if examined != :none && neighbours_opinionated.count > 3
  examined = neighbours_opinionated = :none
end

# If a person without an opinion has exactly 3 opinionated neighbours and at least 2 of them think "Gif" is pronounced with a hard G then they form an opinion that it is pronounced with a hard G
if examined == :none && neighbours_opinionated.count == 3 && neighbours_hard >= 2
  examined = neighbours_opinionated = :hard
end

# If a person without an opinion has exactly 3 opinionated neighbours and at least 2 of them think "Gif" is pronounced with a soft G then they form an opinion that it is pronounced with a soft G
if examined == :none && neighbours_opinionated.count == 3 && neighbours_soft >= 2
  examined = neighbours_opinionated = :soft
end

=end