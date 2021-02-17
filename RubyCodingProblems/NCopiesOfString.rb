#  Create a new string which is n copies of a given string where n is a non-negative integer.
def multipleString(text, number)
    return text * number
end

def printMultipleString
    puts "Enter a text: "
    text = gets.chomp
    puts "Enter an non-negative integer: "
    number = Integer(gets)
    puts "Result: \n" + multipleString(text, number)
end

# Create a new string from a given string using the first three characters or whatever is there if the string is less than length 3.
# Return n copies of the string.
def multipleFirstThreeCharacters(text, number)
    return text.length < 3 ? text * number : text[0..2] * number
end

def printMultipleFirstThreeCharacters
    puts "Enter a text to print the multiplication of the first three characters: "
    text = gets.chomp
    puts "Enter an non-negative integer: "
    number = Integer(gets)
    puts "Result: \n" + multipleFirstThreeCharacters(text, number)
end

# printMultipleString
printMultipleFirstThreeCharacters
