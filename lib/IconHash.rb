module VR

  class IconHash < Hash # :nodoc:
  
    def initialize(path)
      Dir.glob(path + "/*.png").each do |f|
        ext = File.basename(f, ".png")
        self[ext] = Gdk::Pixbuf.new(f)
      end
    end
  
    def get_icon(file_name)
      ext = File.extname(file_name).gsub(".", "")
      self.has_key?(ext) ? self[ext] : self["unknown"] 
    end
  end

end
