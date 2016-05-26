
class ProjectChooserGUI < ProjectChooserView

	include GladeGUI

	def initialize(parent)
		@parent = parent
		@parent.proj_path = nil
		super()
	end
	
	def before_show()	
		@builder["scrolledwindowProjTree"].add(self)
		@builder["window1"].show_all  
		refresh(false)
	end
 

	def buttonOpen__clicked(*args)
		return unless row = selected_rows.first
		@parent.proj_path = row[:file_name]
		@builder["window1"].destroy
	end

	def buttonSelect_clicked
		if folder = VR::Dialog.folder_box(@builder)
  		@parent.proj_path = folder
			@builder["window1"].destroy			
		end
	end

	def checkBackup__toggled(*args)
		refresh(@builder["checkBackup"].active?)
	end	

	def self__row_activated(*args)
		buttonOpen__clicked
	end

	def buttonCancel__clicked(*args)
		@builder["window1"].destroy
	end


end
