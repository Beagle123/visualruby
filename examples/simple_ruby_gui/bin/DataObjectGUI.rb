
class DataObjectGUI 

	include GladeGUI
		

	def initialize(name, address, phone, email)
		@name = name
		@address = address 
		@phone = phone
		@email = email
	end	

	def buttonShow__clicked(*args)
		get_glade_variables() #sets values of @name, @address etc. to values from glade form.
		alert "Curent values:\n\n#{@name}\n#{@address}\n#{@email}\n#{@phone}\n"	
	end

	def buttonCancel__clicked(*args)
		@builder["window1"].destroy
	end

end

