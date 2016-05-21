
class MyClass #(change name)
 
	attr_accessor :ftv

	include GladeGUI

  @ftv = nil

	def before_show()
		path = File.expand_path(ENV['HOME'])
		@ftv = VR::FileTreeView.new(path, "/home/eric/vrp/vr3/img/")
		@ftv.glob = "/.settings.yaml"
		@builder["scrolledwindow1"].add(@ftv)
		@ftv.refresh
		@ftv.expand_row(@ftv.model.iter_first.path, false)
		parse_signals()  #makes method below work:
	end	


  def ftv__row_activated(_self, path, col)
		iter = @ftv.get_iter(path)
		size = File.size( iter[:path] )
 		VR::msg("You selected:		\n\n" + iter[:file_name] + " \n\nsize: " + size.to_s)
	end

end

