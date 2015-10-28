puts "Give me an NxM array!"

@input = gets.chomp

# Trim whitespaces
@input = @input.gsub(" ","")
# Split only the first dimension
@input = @input.split("],[")
@input.each_with_index do |element, index|
    @input[index] = element.gsub(/(\[|\])/,"")
    # Split the second dimension
    @input[index] = @input[index].split(",").map(&:to_sym)
end

puts "The input is: #{@input}"
puts "The class is: #{@input.class}"

# [1,2,3],[1,2,3]
# [soft,hard,none],[soft,hard,none]