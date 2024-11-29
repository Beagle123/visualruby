
class SavableSettings 
 
  include GladeGUI

  def initialize()
    defaults()
  end

  # defaults are set on new and loaded objects.  You can add to this list
  # and it will not cause errors.  New variables will be added
  # and loaded objects will function flawlessly.  When you load a yaml
  # file using VR::load_yaml, it will look for a method named "defaults"
  # and execute it, so use the name "defaults, and it will automatically run.

  def defaults()
    @height ||= 500
    @width ||= 600
    @username ||= "Me Myself and I"
    @switch ||= false
    @checkYesNo ||= false
    @comboFruit ||= "Apples"
    @adjustment2 ||= 58  # applies to  Gtk::Scale control
    @text ||= "Try changing this form, then running it again.  " +
              "You will find that it preserves its state after it closes. " +
              "You can even resize the window, and it will preserve its size.\n\n" +
              "It's storing itself in settings.yaml.  " +
              "To start again, just delete the settings.yaml file." +
              "You may need to click the 'Refresh' to see the settings.yaml file appear again."  
  end  

  def before_show()
    @builder[:window1].resize @width, @height
  end  


  def window1__delete_event(*)
    get_glade_variables
    @width, @height = @builder[:window1].size()
    VR::save_yaml(self)
    return false #ok to close
  end



end

