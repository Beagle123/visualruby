module VR

  # Class that the #alert method uses.  This class is note useful by itself.  See #alert method instead.
  # @see #alert
  # @private
  class AlertDialog   
    
    include GladeGUI
    
    # Just passes on values from #alert method. 
    # @see #alert      

    def initialize(message, flags = {})
      @flags = flags
      @message = message
    end
  
    def before_show
      @builder[:window1].show_all
      @builder[:input_text].hide
      @builder[:ui_grid].hide
      @builder[:choices_text].hide
      @builder[:headline].hide
      @flags[:title] = @flags[:title] ? @flags[:title] : @flags[:headline]
      @builder[:window1].title = @flags[:title] if @flags[:title]
      @builder[:window1].resize(@flags[:width],100) if @flags[:width].to_i > 100
      @builder[:headline].show if @flags[:headline]

      if @flags[:data].is_a? Hash
        row = 0
        @my_hash = @flags[:data]
        @flags[:data].each_pair do |key,val|
          label = Gtk::Label.new(key.to_s + ": ")
          label.halign = :end                                 # use to_s for symbol keys
          @builder["ui_grid"].attach(label, 0, row, 1, 1)
          entry = Gtk::Entry.new(Gtk::EntryBuffer.new(val.to_s))
          entry.hexpand = true
          @builder["ui_grid"].attach(entry, 1, row, 1, 1)
          @my_hash[key] = entry
          row = row + 1
        end
        @flags[:button_yes] ||= "Save"
        @flags[:button_cancel] ||= "Cancel"
        @builder["ui_grid"].show_all
      elsif @flags[:data].is_a? Array
        @flags[:button_yes] ||= "Select"
        @flags[:button_cancel] ||= "Cancel"
        @flags[:data].each { |c| @builder[:choices_text].append_text(c) }
        @choices_text = @flags[:data][0]
        @builder[:choices_text].show 
      elsif @flags[:data].is_a? String
        @flags[:button_yes] ||= "Save"
        @flags[:button_cancel] ||= "Cancel"
        @builder[:input_text].buffer.text = @flags[:data]
        @builder[:input_text].show 
      end
      @builder[:button_no].hide unless @flags[:button_no]
      @builder[:button_cancel].hide unless @flags[:button_cancel]
      set_glade_variables
      set_glade_hash(@flags)
    end

    def run()
      load_glade()
      before_show()
      response = @builder[:window1].run
      case response
        when Gtk::ResponseType::YES
          if @flags[:data].is_a? String
            answer =  @builder[:input_text].buffer.text 
          elsif @flags[:data].is_a? Array
            answer = @builder[:choices_text].active_text
          elsif @flags[:data].is_a? Hash
            answer = @my_hash  # clean up
            @my_hash.each_pair do |key, val| 
              answer[key] = @my_hash[key].buffer.text 
            end   
          else
            answer = true
          end
        when Gtk::ResponseType::NO 
          answer = false
        else 
          answer = nil
      end # case
      @builder[:window1].destroy
      return answer
    end # run

  end

end  

# @param [String] message text message to display in alert box. Uses markup.
# @param [Hash] options Hash of options:  :button_yes => text on the button that returns true.
# @option options [String] :button_yes Text that appears on the "yes" button.
# @option options [String] :button_no Text that appears on "no" button. (set to make no button appear)
# @option options [String] :button_cancel Text that appears on "cancel" button. (set to make cancel button appear)
# @option options [Variable] :data Either String, Array, or Hash.  This will determine type of user input.
# @option options [String] :headline Larger headline over text message.
# @option options [String] :title Title of the alert box window.  Defaults to :headline.
# @option options [Integer] :width The width in pixels of the window. Used for wrapping text. 
# @option options [Object #builder] :parent The window that the alert box is always on top of.
# @return [String] text in the text entry field when the :button_yes button is pressed. (:data passed a String)
# @return [String] selected text from dropdown when the :button_yes button is pressed. (:data passed an Array)
# @return [Hash] When :data is passed as Hash, this is updated Hash from user input.
# @return [true] When the :button_yes button is selected and there's no text entry box.
# @return [false] When :button_no is pressed
# @return [nil] When :button_cancel or the "X" button is pressed.
# The alert method creates a pop-up alert in your program.  It creates a modal
# window that halts execution of your code until the user closes it.  Its great
# for displaying messages and debugging.  It also has the option of allowing the user
# input in the form of a String or a selection from a Hash or Array.  This small tool can save
# hundreds of lines of code in your programs.  It can be used extesnively to
# display all types of messages and request all types of user input.
#
# @example
#  alert("Continue?", button_no: "Nope", button_cancel: "Quit", parent: self) 
# 
# @example
#  alert "The file you selected is already on disk.  Do you want to overwrite it?",
#    headline: "Overwrite FIle?",
#    button_yes: "Overwrite",
#    button_no: "Reload From Disk",
#    button_cancel: "Cancel"
#   
# The alert box can disply 1, 2 or 3 buttons.  The first button is denoted using the symbol: :button_yes
# button and is always displayed.  You can add :button_no and :button_cancel.      
# If you want to add these buttons, just set their values to whatever text you want them to
# display and they will appear.  Likewise, if you pass a :data parameter with a String, Hash or Array,
# it will ask for user input.
#     
# There are many examples in the "alert_box" example project. 

def alert(message, options = {})
  win = VR::AlertDialog.new(message, options)
  return win.run()
end

# alert2("Hello There", data: {name: "", password: ""}, headline: "testing", width: 500)
