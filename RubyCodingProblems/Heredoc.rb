# Print the 'here document' (https://www.rubyguides.com/2018/11/ruby-heredoc/)
def printHeredoc
  text = <<-EOS
  Sample string :
  a string that you "don't" have to escape
  This
  is a ....... multi-line
  heredoc string --------> example
  EOS
  puts text
end

printHeredoc
