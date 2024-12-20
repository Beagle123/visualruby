 
module VR_TabSearch 

  def find_in_all(str, case_sensitive)
    out = "Search Results for:  " + str + "\n"
    out += scan_for_text(str, @docs[self.page].buffer.text, @docs[self.page].full_path_file, case_sensitive)
    (0..self.n_pages-1).each do |i| 
      if i != self.page
        out += scan_for_text(str, @docs[i].buffer.text, @docs[i].full_path_file)
      end
    end
    Find.find(Dir.pwd) do |path|
      Find.prune if path =~ /\/glade$/ or path =~ /\/docs$/ #or File.directory?(path)
      if (File.extname(path) == ".rb" or File.extname(path) == ".erb") and not File.directory?(path) 
        next if not @docs.all? { |doc| doc.full_path_file != path }  # skip open docs
        txt = File.open(path, "r").read
        out += scan_for_text(str, txt, path, case_sensitive)
      end
    end
    return out
  end

  def scan_for_text(str, txt, path, case_sensitive = true)
    i = 1
    out = ''
    txt.each_line do |line|
      found = case_sensitive ? line.include?(str) : line.downcase.include?(str.downcase)
      out += path + ':' + i.to_s + ": Found: "+ str + "\n" if found
      i += 1
    end
    return out
  end  

  def jump_to(line)
    return if line.nil?  
    load_tab(line[:path]) 
    @docs[self.page].jump_to_line(line[:line], line[:search_str])
  end

end
