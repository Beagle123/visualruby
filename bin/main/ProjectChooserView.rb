
class ProjectChooserView < VR::ListView

  PIX = Gdk::Pixbuf.new(File.dirname(__FILE__) + "/../../img/folder.png")

  def initialize()
    super(:folder => {:pix => Gdk::Pixbuf, :file_name => String}, :modified => DateTime) 
    ren_xalign(:modified => 1)
    col_xalign(:modified => 1)
    col_sort_column_id(:modified => id(:modified), :pix => id(:file_name))
  end

  def refresh(show_backup = false)
    # model.set_sort_column_id(1, :ascending)
    self.model.clear
    pattern = ""
    backup_path = Dir.pwd.gsub(ENV["HOME"], File.join(ENV["HOME"], "visualruby_backup"))
    backup_ar = File.split(backup_path)
    backup_ar << ["**", VR_ENV::SETTINGS_FILE]
    if show_backup
      pattern = File.join(*backup_ar)
    else
      pattern = File.join(ENV["HOME"], "visualruby", "**", VR_ENV::SETTINGS_FILE)
    end
    Dir.glob(pattern, File::FNM_DOTMATCH).each do |fn|
      next if not show_backup and fn =~ / Backup /  
      next if show_backup and not fn =~ / Backup / 
      t = File.stat(fn).mtime
      row = add_row()
      row[:pix] = PIX
      row[:file_name] = File.dirname(fn)
      row[:modified] = DateTime.parse(t.to_s)
    end  

#    model.set_sort_column_id(id(:modified), :descending)
  end  
  
end


