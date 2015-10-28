@seating = [:soft,:none,:none],[:soft,:hard,:none],[:soft,:hard,:none]

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