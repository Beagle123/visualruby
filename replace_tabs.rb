

files = Dir.glob(File.join("*", "**", "*.{rb, gemspec}")) 
files.each do |f|
  text = File.open(f).read
  text = text.gsub("\t", "  ")
  File.open(f, "w")  { |fn| fn.puts(text) }
end
