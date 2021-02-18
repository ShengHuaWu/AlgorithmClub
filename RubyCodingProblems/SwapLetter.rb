# Create a new string from a given string where the first and last characters have been exchanged.
def printSwapLetter
  puts "Enter text: "
  text = gets.chomp
  if text.nil? || text.empty?
      puts "Empty input"
      return
  end

  puts(text[-1] << text[1 ... -1] << text[0]) # `-1` means the last element and `...` means excluding the upper bound.
end

printSwapLetter
