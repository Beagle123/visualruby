 
module VR_TabSearch 

  def find_in_tabs(str)
    out = "Search Results for:  " + str + "\n"
    out += scan_for_text(str, @docs[self.page].buffer.text, @docs[self.page].full_path_file)
    (0..self.n_pages-1).each do |i| 
      if i != self.page
        out += scan_for_text(str, @docs[i].buffer.text, @docs[i].full_path_file)
      end
    end
    return out
  end

  def find_in_all(str)
    out = "Search Results for:  " + str + "\n"
    Find.find(Dir.pwd) do |path|
      Find.prune if path =~ /\/glade$/ or path =~ /\/doc$/ #or File.directory?(path)
      if (File.extname(path) == ".rb" or File.extname(path) == ".erb") and not File.directory?(path) 
        txt = File.open(path, "r").read
        out += scan_for_text(str, txt, path)
      end
    end
    return out
  end

  def replace(str_replacement)
    @docs[self.page].replace(str_replacement)
  end

  def scan_for_text(str, txt, path)
    i = 1
    out = ''
    txt.each_line do |line|
      match = line.scan(str)
      out += path + ':' + i.to_s + ": Found: "+ str + "\n" if match.size > 0
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
