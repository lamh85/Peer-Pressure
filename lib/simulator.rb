class Simulator

  attr_accessor :seating

  def initialize(input)
    @seating = input.to_s

    # Convert the user input into a 2-dimensional array
    # ---
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
    frequencies = {hard: 0, soft: 0}
    @seating.each do |row|
        row.each do |seat|
            if frequencies[seat]
                frequencies[seat] = frequencies[seat] + 1
            end
        end
    end
    frequencies = Hash[frequencies.sort_by{ |k,v| v }.reverse]

    if frequencies.values[0] > frequencies.values[1]
        verdict = frequencies.keys[0]
    elsif frequencies.values[0] == frequencies.values[1]
        verdict = :push
    end
    puts "The verdict is: #{verdict}"
  end

  def state
    puts "==="
    puts "The current seating is: "
    @seating.each do |row|
      print row
      puts ""
    end
    puts "==="
  end

  def next
    @influencers = @seating.map(&:dup)
    index_modifiers = [-1, -1],[-1, 0],[-1, +1],[0, -1],[0, +1],[1, -1],[1, 0],[1, +1]    
    # Loop through each row
    @influencers.each_with_index do |row, row_index|
        # Loop throubh each seat of the row
        row.each_with_index do |seat, seat_index|

            # Build a temporary array of valid neighbours
            neighbours = []
            index_modifiers.each do |modifier|
                if valid_index?(@influencers, row_index + modifier[0]) && valid_index?(row, seat_index + modifier[1])
                    neighbours << @influencers[row_index + modifier[0]][seat_index + modifier[1]]
                end
            end

            # Count the neighbouring opinions
            frequencies = {hard: 0, soft: 0, none: 0}
            neighbours.each do |element|
                frequencies[element] = frequencies[element] + 1
            end

            # Logic for changing opinion
            # Had an opinion
            if @seating[row_index][seat_index] != :none
                if frequencies[:hard] + frequencies[:soft] < 2
                    @seating[row_index][seat_index] = :none
                end
                if frequencies[:hard] + frequencies[:soft] > 3
                    @seating[row_index][seat_index] = :none
                end
                # if opinionated neighbours == 2 or 3, then no change
            # Had no opinion
            elsif @seating[row_index][seat_index] == :none && frequencies[:hard] + frequencies[:soft] == 3
                if frequencies[:hard] >= 2
                    @seating[row_index][seat_index] = :hard
                end
                if frequencies[:soft] >= 2
                    @seating[row_index][seat_index] = :soft
                end
            end # opinion logic
                
        end # loop each seat
    end # loop each row
  end # class method

  private

  # Can the index be found within the array?
  def valid_index?(array, index_number)
      if index_number >= 0 && index_number < array.length
          return true
      end
  end

end


=begin

MECHANISM FOR EVALUATING THE RESULT OF ONE PERSON:
0: Convert the inputted string into an array
1: ID the person via index numbers
2: ID the person's neighbours and return an array
3: Evaluate the array: find the conditional that fits the description of the array

# If person HAD OPINION
# ---------------------

# If a person {with an opinion} has {fewer than 2 opinionated neighbours} then they stop having an opinion since there are not enough people to argue with.
if examined != :none && neighbours_opinionated.count < 2
  examined = :none
end

# If a person {with an opinion} has {more than 3 opinionated neighbours} then they stop having an opinion since their opinion is drowned out by their neighbours.
if examined != :none && neighbours_opinionated.count > 3
  examined = :none
end

# If person had NO OPINION + exactly 3 opinionated neighbours
# -----------------------------------------------------------

# If a person {without an opinion} has {exactly 3 opinionated} neighbours and {at least 2 of them think "Gif" is pronounced with a hard G} then they form an opinion that it is pronounced with a hard G
if examined == :none && neighbours_opinionated.count == 3 && neighbours_hard >= 2
  examined = :hard
end

# If a person {without an opinion} has {exactly 3 opinionated} neighbours and {at least 2 of them think "Gif" is pronounced with a soft G} then they form an opinion that it is pronounced with a soft G
if examined == :none && neighbours_opinionated.count == 3 && neighbours_soft >= 2
  examined = :soft
end

=end