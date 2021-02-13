#  Create a new string which is n copies of a given string where n is a non-negative integer.
def multiple_string(text, number)
    return text * number
end

def printMultipleString
    puts "Enter a text: "
    text = gets
    puts "Enter an non-negative integer: "
    number = Integer(gets)
    puts "Result: \n" + multiple_string(text, number)
end

printMultipleString