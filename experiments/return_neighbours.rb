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

def index_modifier(row_index, seat_index)
    return 
end

index_modifiers = [-1, -1],[-1, 0],[-1, +1],[0, -1],[0, +1],[1, -1],[1, 0],[1, +1]

# Can the index be found within the array?
def valid_index?(array, index_number)
    if index_number >= 0 && index_number < array.length
        return true
    end
end

# Loop through each row
@seating.each_with_index do |row, row_index|
    # Loop throubh each seat of the rool
    row.each_with_index do |seat, seat_index|
        puts "==="
        puts "The current seat's index is #{row_index}, #{seat_index}"
        neighbours = []

        index_modifiers.each do |modifier|
            if valid_index?(@seating, row_index + modifier[0]) && valid_index?(row, seat_index + modifier[1])
                neighbours << @seating[row_index + modifier[0]][seat_index + modifier[1]]
            end
        end

        puts "The neighbours are: #{neighbours}"
    end
end