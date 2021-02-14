# Accept the user's first and last name 
# and print them in reverse order with a space between them.

def printReversedInput
    puts "Enter your first name: "
    firstName = gets.chomp # `chomp` will remove any newline or space
    puts "Enter your last name: "
    lastName = gets.chomp
    puts "Hello " + lastName + " " + firstName
end

printReversedInput