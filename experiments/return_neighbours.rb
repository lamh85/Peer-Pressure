=begin
visual representation:
0   [soft,hard,none]
    0,      1,  2
1   [soft,hard,none]
    0,      1,  2
2   [soft,hard,none]
    0,      1,  2

=end

@seating = [:soft,:hard,:none],[:soft,:hard,:none],[:soft,:hard,:none]
@influencers = @seating.map(&:dup)

index_modifiers = [-1, -1], [-1, 0], [-1, +1], [0, -1], [0, +1], [1, -1], [1, 0], [1, +1]

# Can the index be found within the array?
def valid_index?(array, index_number)
    if index_number >= 0 && index_number < array.length
        return true
    end
end

# Loop through each row
@influencers.each_with_index do |row, row_index|
    # Loop throubh each seat of the row
    row.each_with_index do |seat, seat_index|
        puts "==="
        puts "The current seat's index is #{row_index}, #{seat_index}"

        # Build an array of valid neighbours
        neighbours = []
        index_modifiers.each do |modifier|
            if valid_index?(@influencers, row_index + modifier[0]) && valid_index?(row, seat_index + modifier[1])
                neighbours << @influencers[row_index + modifier[0]][seat_index + modifier[1]]
            end
        end
        puts "The neighbours are: #{neighbours}"

        # Count the neighbouring opinions
        frequencies = {hard: 0, soft: 0, none: 0}
        neighbours.each do |element|
            frequencies[element] = frequencies[element] + 1
        end
        puts "The frequencies are: #{frequencies}"

        # Influencers affecting the opinion
        puts "The opinion WAS #{@seating[row_index][seat_index]}"
        # Had an opinion
        if @seating[row_index][seat_index] != :none
            if frequencies[:hard] + frequencies[:soft] < 2
                @seating[row_index][seat_index] = :none
                puts "The opinion IS NOW #{@seating[row_index][seat_index]}"
            end
            if frequencies[:hard] + frequencies[:soft] > 3
                @seating[row_index][seat_index] = :none
                puts "The opinion IS NOW #{@seating[row_index][seat_index]}"
            end
            # if opinionated neighbours == 2 or 3, then no change
        # Had no opinion
        elsif @seating[row_index][seat_index] == :none && frequencies[:hard] + frequencies[:soft] == 3
            if frequencies[:hard] >= 2
                @seating[row_index][seat_index] = :hard
                puts "The opinion IS NOW #{@seating[row_index][seat_index]}"
            end
            if frequencies[:soft] >= 2
                @seating[row_index][seat_index] = :soft
                puts "The opinion IS NOW #{@seating[row_index][seat_index]}"
            end
        end # opinion logic
            
    end # loop each seat
end # loop each row

puts "The seating is now:"
@seating.each do |row|
    print row
    puts ""
end