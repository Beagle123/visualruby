
module VR



	def VR.msg(*a)  Dialog.message_box(*a) end

  module Dialog
 
  	
  	def Dialog.input_box(message, default="", title = "Visual Ruby")
        dialog = Gtk::MessageDialog.new(
          :parent => nil,
          :flags => :modal,
          :type => :question,
          :buttons => :ok_cancel, 
          :message => message)
  			dialog.title = title
  			input = Gtk::Entry.new
  			dialog.child.add(input)
  			dialog.show_all
  			ret = ""
      if dialog.run == :ok # Gtk::Dialog::RESPONSE_OK
  					ret = input.buffer.text
  				else
  					ret = false
  			end
      dialog.destroy
  			return ret
  	end
  
  	def Dialog.ok_box(message, title = "Visual Ruby")
        dialog = Gtk::MessageDialog.new(
          :parent => nil,
          :flags => :modal,
          :type => :question,
          :buttons => :ok_cancel,
          :message => message)
  				dialog.title = title
        ret = (dialog.run == :ok)
       	dialog.destroy
  			return ret
  	end
  
  	def Dialog.folder_box(builder)
      dialog = Gtk::FileChooserDialog.new(
						:title => "Select Folder...",
          :parent => builder['window1'],
          :action => :select_folder,
          :buttons => [["_Cancel", :cancel],
                      ["_Accept", :accept]]

				)
      if dialog.run == :accept
        ret =  dialog.current_folder
  		else
  			ret = false
      end 
      dialog.destroy
  		return ret
    end
  end

end  
