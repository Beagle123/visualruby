
class SavableSettings 
 
	include GladeGUI
#	include Savable

	attr_accessor :height, :width, :title, :text

	def initialize()
		defaults()
	end

	# defaults are set on new and loaded objects.  You can add to this list
	# and it will not cause errors.  New variables will be added
	# and loaded objects will function flawlessly. 
	def defaults()
		@height ||= 200
		@width ||= 350
		@title ||= "Savable Settings Demo"
		@text ||= "Try changing the window size, title and text in this window.  You will see that it saves its state " +
			"to a file named settings.yaml.  So when you run this program again, it will be the same as " +
			"when you left.  To see this file, click the 'Refresh' button. To reset to " +
			"defaults, just delete settings.yaml."
	end	

	def buttonSave__clicked(*a)
		get_glade_variables
		VR::save_yaml(self) 
		@builder[:window1].destroy
	end

	def buttonCancel__clicked(*a)
		@builder[:window1].destroy
	end

end

