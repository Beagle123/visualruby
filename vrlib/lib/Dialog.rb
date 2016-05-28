
module VR

  module Dialog
  
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
