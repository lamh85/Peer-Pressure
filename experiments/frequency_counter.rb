array = [:hard, :soft, :none, :hard, :soft, :soft]

frequencies = { hard: 0, soft: 0, none: 0}
array.each do |element|
    frequencies[element] = frequencies[element] + 1
end

puts frequencies