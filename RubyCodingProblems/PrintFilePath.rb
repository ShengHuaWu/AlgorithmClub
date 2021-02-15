def printFilePath
  puts "Enter the file path: "
  path = gets.chomp

  file = File.basename(path)
  puts "File name: " + file

  ext = File.extname(path)
  puts "Extension: " + ext

  basename = File.basename(path, ext) # Exclude the extension
  puts "Basename: " + basename

  dir = File.dirname(path)
  puts "Directory: " + dir
end

printFilePath
