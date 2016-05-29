
class OpenProject

	include GladeGUI

	def initialize(parent)
		@parent = parent
		@projects_home = $VR_ENV_GLOBAL.projects_home
	end

	def before_show
		@ftv = ProjectTree.new()
		@builder["view"].add(@ftv)
		@builder["view"].show_all
	end

  def ftv__row_activated(_self, path, col)
		buttonOpen__clicked
	end

	def buttonChange__clicked(*a)
		$VR_ENV_GLOBAL.show(self)
		@projects_home = $VR_ENV_GLOBAL.projects_home
		@ftv.refresh(@projects_home)
	end

	def buttonDelete__clicked(*a)
  	return unless row = @ftv.selected_rows.first
		return if row[:path] == Dir.pwd  #can't delete current project
		if alert("Do you really want to delete  <b>" + row[:path] + " </b>?", 
				:parent=>self, :headline=>"Warning!", :button_yes=>"Delete", :button_no=>"Cancel")
  		FileUtils.remove_dir(row[:path], true)
			@ftv.refresh()
  	end
	end

	def buttonOpen__clicked(*a)
  		return unless row = @ftv.selected_rows.first
			test_file = File.join(row[:path], VR_ENV::SETTINGS_FILE)
			if File.exists?(test_file) or alert("This is not a visualruby project.  It's a folder that holds visualruby projects.  Open it anyway?", :parent=>@parent, :button_no => "Cancel")
 				@parent.proj_path = row[:path]
				buttonCancel__clicked
			end
	end

	def buttonCancel__clicked(*a) #save state
		$VR_ENV_GLOBAL.projects_home_open_folders = @ftv.get_open_folders()
		$VR_ENV_GLOBAL.save_yaml()
		@builder["window1"].destroy		
	end

end
