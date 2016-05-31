
class ProjectTreeGUI #(change name)
 
	attr_accessor :ftv

	include GladeGUI

	def before_show()
		@ftv = ProjectTree.new()
		@builder["scrolledwindow1"].add(@ftv)  #needs show_all
		@open_folders = []
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

