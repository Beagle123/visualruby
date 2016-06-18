
module VR

#  The TextCol class is a simple text editor for editing strings of data:
#  
#  http://visualruby.net/img/textcol.jpg
#  
#  It is a very useful class when you want to display and edit long strings
#  of data in a VR::ListView.  To create a coulmn of long strings in a VR::ListView,
#  simply define the column type as VR::TextCol:
#  
#   @view = VR::ListView.new(:name => String, :quote => VR::TextCol)
#   row = @view.add_row
#   row[:name] = "Eric"
#   row[:quote] = VR::TextCol.new("I have come to believe that the whole world is an enigma, a harmless enigma that is made terrible by our own mad attempt to interpret it as though it had an underlying truth.  - Umberto Eco) ")
#  
#  The above listview will only display the first 20 characters of the quote, so
#  it won't destroy the appearance of the listview.  When a user clicks on the
#  quote column, a window like the one above will appear.
#  
#  See the example project, "listview_objects" for more.

  class TextCol 

    include GladeGUI

    attr_accessor :text, :length_to_display
#  
#  - text - String value of the field
#  - length_to_display - Integer number of characters to display in the listview. Default: 20
#  
    def initialize(text, length_to_display = 20)
      @length_to_display = length_to_display
      @text = text
    end

    def before_show()
      @builder["window1"].resize 650, 360
    end

#  The to_s method outputs the string that is shown in the VR::ListView.  By default
#  it will display the first 20 characters of the string.  If you
#  want to change the number of characters it displays, change the
#  value of the length_to_display variable.

    def to_s
      (@text.size > @length_to_display ? @text[0, @length_to_display - 4] + "..." :  @text).gsub("\n"," ")
    end

    def buttonSave__clicked(*args) # :nodoc:
      get_glade_variables()
      @builder["window1"].destroy
    end

    def buttonCancel__clicked(*args) # :nodoc:
      @builder["window1"].destroy
    end

    def <=>(text_col)
      self.text <=> text_col.text
    end

  end

end
