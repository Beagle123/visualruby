
  
module VR::Col

#  The Combo class is for use with VR::ListView and VR::TreeView.  It
#  simply holds the values for a combobox to be displayed in the view.
#  It is not a visual component, it just holds data.
#  
#  It is one of the data types that you can pass to the constructors for VR::ListView and
#  VR::TreeView.  For example, to make the second column render as a combobox:
#  
#    @view = VR::Treeview.new(Gdk::Pixbuf, VR::Combo, String)
#  
#  Then when you add data to the model:
#  
#    @view.add_row(@pixbuf, VR::Combo.new("Mr", "Mr", "Mrs", "Ms"), "Hello World")
#  
#  This would set the combobox for this row so that "Mr" is selected, and "Mr", "Mrs", and "Ms" are the choices. 


  class ComboCol # can't subclass String tried twice!!!
  
    attr_accessor :selected, :selections  
  
#  This defines a combobox for a row in VR::ListView or VR::TreeView.  You pass three or more strings
#  to the constructor, and the first string is the selected value that appears in the row in the 
#  view.
#  
#  - current_selection (type String)
#  - selections (comma separated list of Strings)  
#  
    def initialize(current_selection, *selections)
      @selected = current_selection
      @selections = selections
    end

    def valid?(str)
      @selections.include?(str)
    end

  end

end
