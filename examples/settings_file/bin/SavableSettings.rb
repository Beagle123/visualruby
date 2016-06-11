
class SavableSettings 
 
  include GladeGUI
#  include Savable

  attr_accessor :height, :width, :title, :text

  def initialize()
    defaults()
  end

  # defaults are set on new and loaded objects.  You can add to this list
  # and it will not cause errors.  New variables will be added
  # and loaded objects will function flawlessly. 
  def defaults()
    @height ||= 200
    @width ||= 350
    @title ||= "Savable Settings Demo"
    @text ||= "Try running this program multiple times.\n\n" +
              "It will create a file named settings.yaml that stores " +
              "the height, width, title, and text from this window, so the " +
              "window will be restored to the same state as when you exited.\n\n " +
              "If you want to reset the file to the defaults, just delete the settings.yaml file.\n\n" +
              "You may need to click the 'Refresh' to see the settings.yaml file."
  end  

  def buttonSave__clicked(*a)
    get_glade_variables
    VR::save_yaml(self) 
    @builder[:window1].destroy
  end

  def buttonCancel__clicked(*a)
    @builder[:window1].destroy
  end

end

