
#class Splash #(change name)
#
#	include GladeGUI
#
#	def show(parent)
#		load_glade(__FILE__)  #loads file, glade/MyClass.glade into @builder
#		@builder["image1"].file = File.dirname(__FILE__) + "/../../img/splash.png" 
#		show_window()
##		wait_destroy()
#	end	
#	
#	def wait_destroy
#		t = Thread.new { 
#			sleep(1.5)
#			@builder["window1"].destroy
##			destroy_window()
#			t.join
#		}
#	end
#
#
#end
