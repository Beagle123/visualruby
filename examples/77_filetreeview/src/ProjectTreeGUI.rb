
class ProjectTreeGUI #(change name)
 
  attr_accessor :ftv

  include GladeGUI

  def before_show()
    @ftv = ProjectTree.new()
    @builder["scrolledwindow1"].add(@ftv)  #needs show_all
    @ftv.set_show_expanders(false)
    @open_folders = []
  end  

  def ftv__row_activated(_self, path, col)
      return unless row = @ftv.selected_rows.first
      if File.exist?(File.join(row[:path], ".vr_settings.yaml")) #test if its a vr project.
         alert "You selected:    \n\n" + row[:file_name]
      else
        @ftv.expand_or_collapse_folder()
      end
  end

  def show_expanders__toggled(*a)
    @ftv.set_show_expanders(@builder[:show_expanders].active?)
  end

  def save_state__clicked(*a)
    @open_folders = @ftv.get_open_folders()
    alert("Saving folders: " + @open_folders.to_s, :parent=>self)
  end

  def load_state__clicked(*a)
    @ftv.refresh( :open_folders => @open_folders )
  end

end

