class Person < ActiveRecord::Base

    include GladeGUI

    def before_show
      @builder[:labelName].label = "<big>#{name}</big>" 
      set_glade_all() # updates entry boxes
    end
    
    # this is what shows in the listview
    def to_s 
      "#{self.name}  (#{self.email})  #{self.phone}" 
    end

    def buttonSave__clicked(*a)
      get_glade_all #sets name, address, phone etc. from glade
      save!
      @builder[:window1].close
    end

end
