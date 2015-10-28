class Simulator

  attr_accessor :seating

  def initialize(input)
    @seating = input.to_s
    format_input
  end

  # Convert the user input into a 2-dimensional array
  def format_input
    # Trim whitespaces
    @seating = @seating.gsub(" ","")
    # Split only the first dimension
    @seating = @seating.split("],[")
    @seating.each_with_index do |element, index|
        # Remove square brackets
        @seating[index] = element.gsub(/(\[|\])/,"")
        # Split the second dimension
        @seating[index] = @seating[index].split(",").map(&:to_sym)
    end    
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

MECHANISM FOR EVALUATING THE RESULT OF ONE PERSON:
0: Convert the inputted string into an array
1: ID the person via index numbers
2: ID the person's neighbours and return an array
3: Evaluate the array: find the conditional that fits the description of the array

# If a person with an opinion has fewer than 2 opinionated neighbours then they stop having an opinion since there are not enough people to argue with.
if examined != :none && neighbours_opinionated.count < 2
  examined = :none
end

# If a person with an opinion has more than 3 opinionated neighbours then they stop having an opinion since their opinion is drowned out by their neighbours.
if examined != :none && neighbours_opinionated.count > 3
  examined = :none
end

# If a person without an opinion has exactly 3 opinionated neighbours and at least 2 of them think "Gif" is pronounced with a hard G then they form an opinion that it is pronounced with a hard G
if examined == :none && neighbours_opinionated.count == 3 && neighbours_hard >= 2
  examined = :hard
end

# If a person without an opinion has exactly 3 opinionated neighbours and at least 2 of them think "Gif" is pronounced with a soft G then they form an opinion that it is pronounced with a soft G
if examined == :none && neighbours_opinionated.count == 3 && neighbours_soft >= 2
  examined = :soft
end

=end