puts "Give me an NxM array!"

@seating = gets.chomp

# Trim whitespaces
@seating = @seating.gsub(" ","")
# Split only the first dimension
@seating = @seating.split("],[")
@seating.each_with_index do |element, index|
    @seating[index] = element.gsub(/(\[|\])/,"")
    # Split the second dimension
    @seating[index] = @seating[index].split(",").map(&:to_sym)
end

puts "The input is: #{@seating}"
puts "The class is: #{@seating.class}"

=begin
[soft,hard,none],[soft,hard,none],[soft,hard,none]

[soft,hard,none]
[soft,hard,none]
[soft,hard,none]
=end