class Simulator

  attr_accessor :seating

  def initialize(input)
    @seating = input
  end

  def verdict
    frequencies = {hard: 0, soft: 0}
    @seating.each do |row|
        row.each do |seat|
            frequencies[seat] = frequencies[seat] + 1 if frequencies[seat]
        end
    end

    return :push if frequencies[:hard] == frequencies[:soft]
    return :hard if frequencies[:hard] > frequencies[:soft]
    return :soft
  end

  # I added this method because I was disappointed that SPEC doesn't want "state" to return pretty formatting =P
  def state_pretty
    puts "==="
    puts "The current seating is: "
    @seating.each do |row|
      print row
      puts ""
    end
    puts "==="
  end

  def state
    return @seating
  end

  def next
    @influencers = @seating.map(&:dup)
    index_modifiers = [ [-1,-1],  [-1,0],   [-1,1],
                         [0,-1],             [0,1], 
                         [1,-1],   [1,0],    [1,1] ]
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
            if @seating[row_index][seat_index] != :none # Had an opinion
                if  frequencies[:hard] + frequencies[:soft] < 2 ||
                    frequencies[:hard] + frequencies[:soft] > 3
                    @seating[row_index][seat_index] = :none
                end
                # if opinionated neighbours == 2 or 3, then no change
            elsif   @seating[row_index][seat_index] == :none &&
                    frequencies[:hard] + frequencies[:soft] == 3 # Had no opinion
                @seating[row_index][seat_index] = :hard if frequencies[:hard] >= 2
                @seating[row_index][seat_index] = :soft if frequencies[:soft] >= 2
            end # opinion logic
                
        end # loop each seat
    end # loop each row
  end

  private

  # Can the index be found within the array?
  def valid_index?(array, index_number)
      if index_number >= 0 && index_number < array.length
          return true
      end
  end

end