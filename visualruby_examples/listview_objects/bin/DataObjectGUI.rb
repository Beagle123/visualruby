##
#  This demonstrates how you can easily add a GUI to any ruby class.
#  The class DataObject holds all the logic for the class and
#  DataObjectGUI holds all the GUI elements.  This is a very good
#  way to use visualruby because it keeps your code organized.
#  
#  Also, you can easily add a GUI to any of your existing ruby classes by
#  simply making a class, MyClassGUI, that  is a subclass of your existing class.
#  
#  In this example, I've added a button to the glade form with the name, "buttonShow.'
#  The button's "clicked" signal (see 'signal' tab in glade) is set to 
#  "buttonShow_clicked."  That means when the user clicks the button,
#  the method "buttonShow_clicked" will be called in this file.  You can see 
#  the code below.
#
#  Notice that in glade, the entry fields are named:
#  
#  DataObjectGUI.name
#  DataObjectGUI.address   ...etc.
#  
#  This is so that set_glade_all() and get_glade_all() will be able to map them to
#  the instance variables.
#  

class DataObjectGUI < DataObject

	include GladeGUI


	def buttonShow__clicked(button)
		get_glade_all() #this sets the instance variables from values in the glade form.
		VR::Dialog.message_box("Curent values:\n\n#{@name}\n#{@address}\n#{@email}\n#{@phone}\n")		
	end

end

