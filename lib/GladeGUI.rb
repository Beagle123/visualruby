# =GladeGUI
#
# GladeGUI connects your class to a glade form. 
# It will load a .glade
# file into memory, enabling your ruby programs to have a GUI interface.
#  
# GladeGUI works by adding an instance variable named "builder" to your class.  The "builder"
# variable is an instance of {Gtk::Builder}[http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk%3A%3ABuilder]
# It holds references to all your windows and widgets.
#  
# = Include the GladeGUI interface
#  
# To use the GladeGUI interface, include this line in your code:
# 
# 
#   class MyClass
#     include GladeGUI
#   end
# 
# GladeGUI will load a corresponding 
# glade file for this class.  It knows which glade file to load by using a naming 
# convention:
#  
#   /folder/MyClass.rb 
#  
# Will load this glade file:
#  
#   /folder/glade/MyClass.glade
#  
# The class, the class file name and the glade file name must match.
# You should always name your class, script, and glade file
# the same name (case sensitive).
#  
# == <tt>builder</tt> variable holds all your widgets
#  
# So when you "load" your class's glade file where is it loaded?
#  
# GladeGUI adds an instance variable, builder to your class.
# It loads all the windows and widgets from your glade file into @builder.
# So, you use <tt>@builder</tt> to manipulate everything in you class's GUI.
# <tt>@builder</tt> is set when you call the show_glade() method, as this code shows:
#  
#   class MyClass
#    
#     include GladeGUI
#      
#     def initialize()
#       puts @builder.to_s  #  => nil
#     end
#     
#     def before_show()
#       puts @builder.to_s   #  => Gtk::Builder
#     end  
#    
#   end
#  
# After show_glade() is called, you can access any of your form's windows or widgets
# using the @builder variable: 
# ```ruby 
#   @builder["window1"].title = "This is the title that appears at the top."
# ``` 
#  
# Here's another example:  Suppose you have a glade form with a Gtk::Entry box on it named "email."
# You could set the text that appears in the Gtk::Entry by setting the Gtk::Entry#text property:
# ```ruby 
#   @builder["email"].text = "harvey@harveyserver.com"
# ```  
# Now the email adddess is set with a new value:
# 
# http://visualruby.net/img/gladegui_simple.jpg
#  
# == Auto fill your glade form
# You can streamline the process of setting-up your forms by
# auto-filling the widgets from instance variables with the same name.
#
# When assigning names to widgets in glade, give them names that 
# correspond to your instance variables. For example, if you want 
# to edit an email address on the glade form, create an instance 
# variable named @email in your class. Then, in glade, you 
# add a Gtk::Entry widget to your form and set its name to 
# “email”. The advantage of this is that GladeGUI will populate 
# the “email” widget in glade using the @email variable. so 
# you don’t need to include the above line of code. (see 
# set_glade_variables() method.)
module GladeGUI

# @!attribute [rw] builder
#   @return [Gtk::Builder] The builder that holds references to everything in the glade form.
  attr_accessor :builder

##
#
#  drag_to() will make it so you can drag-n-drop the source_widget onto the target widget.
#  You may pass a reference to a widget object, or a String that gives the name of the
#  widget on your glade form. So, it functions the same as this statement:
#  
#      widget_source.drag_to(widget_target)
#  
#  It also functions the same as this statement:
#  
#      @builder["widget_source"].drag_to(@builder["widget_target"])
#  
#  

def set_drag_drop(hash)
  hash.each do |key,val|
    src = key.is_a?(Gtk::Widget) ? key : @builder[key]
    target = @builder[val]
    src.extend(VR::Draggable) unless src.is_a?(VR::Draggable)
    src.add_target_widget(target)
  end
end



##
# This will Load the glade form according to the naming convention: MyClass.rb => MyClass.glade.  
# It will create a Gtk::Builder object from your glade file.
# The Gtk::Builder object is stored in the instance variable, @builder.
# You can get a reference to any of the widgets on the glade form by
# using the @builder object:
#
# @example 
#  widget = @builder["name"]
#  
# Normally, you should give your widgets names of instance variables: i.e. @email
# so they can be autoloaded when the glade form is shown using the #show_glade method.  For example,
# the value of the @email vaiable would be loaded into a Gtk:Entry named "email"
# in your glade form.  It saves you from having to do this:
#
# @example
#  @builder[:email].text = @email
#   
  def load_glade() 
    caller__FILE__ = my_class_file_path() 
    file_name = File.join(File.split(caller__FILE__)[0] , "glade", class_name(self) + ".glade")
    @builder = Gtk::Builder.new
    @builder << file_name
    @builder.connect_signals{ |handle| method(handle) }
  end

  private def class_name(obj) 
    /.*\b(\w+)$/.match(obj.class.name)[1]
  end    

#  Connects gtk's signals to your methods according to the naming convention widget__signal.  For example,
#  when you place a button called "button1" in your glade form, and declare a method called 
#  "button1__clicked", they aren't connected to each other.  Clicking on the button does nothing
#  and the method never gets called.  After running parse_signals(), the "clicked" signal is
#  connected to the method named "button1__clicked" so when the user clicks the button, the method is called.  
#  
# @example methods
#  button1__clicked(*args)
#  self__row_activated(*args)
#  instance_variable__key_press_event(*args)
#
# Remember that it will enforce the naming convention:  name__signal (two underscores). 
  def parse_signals()
    meths = self.class.instance_methods()
    meths.each do |meth|
      meth = meth.to_s #bug fix ruby 1.9 gives stmbol
      glade_name, signal_name = *(meth.split("__"))
      next if (signal_name.to_s == "" or glade_name.to_s == "") #covers nil
      if @builder
        @builder.objects.each do |obj|
          next unless obj.respond_to?(:builder_name)
          if obj.builder_name == glade_name or obj.builder_name =~ /^(?:#{class_name(self)}\.|)#{glade_name}\[[a-zA-Z\d_-]+\]$/ #arrays
            obj.signal_connect(signal_name) { |*args| method(meth.to_sym).call(*args) } 
          end
        end
      end
      obj = glade_name == "self" ? self : self.instance_variable_get("@" + glade_name)
      obj ||= eval(glade_name) if respond_to?(glade_name) and method(glade_name.to_sym).arity == 0 # no arguments!
      if obj.respond_to?("signal_connect")
        obj.signal_connect(signal_name) { |*args| method(meth.to_sym).call(*args) }
      end
    end
  end

# parses instance variables added in before_show
#  def parse_instance_signals(dig = true)
#    instance_variables.each do |var|
#      obj = instance_variable_get(var)
#      if obj.respond_to?(:load_glade)
#        obj.load_glade
#        obj.parse_signals                         # dig one level
#        obj.parse_instance_signals(false) if dig  # never ending loop if instance vaiables are in 2 objects
#      end
#    end
#  end    

#  This method is the most useful method to populate a glade form.  It will
#  populate from active_record fields and instance variables.  It will simply 
#  call both of these methods:
#  
#   set_glade_active_record()
#   set_glade_variables()
#  
#  So, to set all the values of a form, simply call the set_glade_all() method instead.

  def set_glade_all(obj = self) 
    set_glade_active_record(obj)
    set_glade_variables(obj)
#    set_glade_hash(obj) if obj.is_a?(Hash) #only needed for Hash subclass. needed?
  end

#  This method is the most useful method to retreive values from a glade form.  It will
#  populate from active_record fields and instance variables.  It will simply 
#  call both of these methods:
#  
#   get_glade_active_record()
#   get_glade_variables()
#  
#  So, to retreive all the values of a form back into your ActiveRecord object and instance variables, simply call the set_glade_all() method instead.

  def get_glade_all(obj = self)
    get_glade_active_record(obj)
    get_glade_variables(obj)
  end

# Populates the glade form from the fields of an ActiveRecord object.
# So instead of having to assign each widget a value:
# @example 
#  @builder["name"].text = @name
#  @builder["address"].text = @address
#  @builder["email"].text = @eamil
#  @builder["phone"].text = @phone
# 
# You can write one line of code:
# @example 
#  set_glade_active_record()
#  
# The optional parameter is seldom used because you usually want the
# glade form to populate from the calling class.  If you passed another object,
# the form would populate from it.
#  
# @param [ActiveRecord::Base] obj Any activerecod base object.
# @return none 
  def set_glade_active_record(obj = self) 
    return if not defined? @attributes
    obj.attributes.each_pair { |key, val| fill_control(class_name(obj) + "." + key, val) }
  end

# Matches names in glade form to keys in a Hash.  
# @param [Hash] hash The hash with keys that match the names in the glade form.
  def set_glade_hash(hash)
    return unless hash.is_a?(Hash)
    hash.each { |key,val| fill_control( key.to_s, val.to_s) }
  end

# Populates the glade form from the instance variables of the class.
# So instead of having to assign each widget a value:
#
#    @builder["name"].text = @name
#    @builder["address"].text = @address
#    @builder["email"].text = @eamil
#    @builder["phone"].text = @phone
#
# you can write one line of code:
#
#  set_glade_variables()
#
# The optional parameter is seldom used because you usually want the
# glade form to populate from the calling class.  If you passed another object,
# the form would populate from it.
#
# obj - type Object
#
  def set_glade_variables(obj = self)
    obj.instance_variables.each do |name|
      name = name.to_s #ruby 1.9 passes symbol!
      v = obj.instance_variable_get(name)
      name = name.gsub('@', '')
      if v.is_a?(Array) 
        v.each_index do |i|
          fill_control("#{name}[#{i.to_s}]", v[i] )
        end
      elsif v.is_a?(Hash)
        v.each_pair do |key, val|
          fill_control("#{name}[#{key.to_s}]", val)
        end        
      else
        fill_control(name, v)
      end
    end
  end
  

  def fill_control(glade_name, val) 
    control = @builder[glade_name]
    return unless control
    case control  # order matters-- subclasses?
      when Gtk::Window then control.title = val
      when Gtk::CheckButton then control.active = val
      when Gtk::TextView then control.buffer.text = val.to_s
      when Gtk::Entry then control.text = val.to_s
      when Gtk::ColorButton then control.color = Gdk::Color.parse(val.to_s)
      when Gtk::FontButton then control.font_name = val.to_s
      when Gtk::LinkButton then control.uri = control.label = val.to_s 
      when Gtk::Label, Gtk::Button then control.label = val.to_s
      when Gtk::Image then control.file = val.to_s 
      when Gtk::SpinButton then control.value = val.to_f
      when Gtk::ProgressBar then control.fraction = val.to_f
      when Gtk::Calendar then control.select_month(val.month, val.year) ; control.select_day(val.day) ; control.mark_day(val.day)
      when Gtk::Adjustment then control.value = val.to_f
      when Gtk::ScrolledWindow, Gtk::Frame, Gtk::VBox, Gtk::HBox then control.add(val)
      when Gtk::ComboBoxText then try_to_select_text_in_combobox(control, val.to_s)
    end      
  end

  def try_to_select_text_in_combobox(cb, text)
    i = 0
    cb.model.each do |model, path, iter|
      if iter[0] == text
        cb.active = i
        return
      end  
      i = i + 1
    end
  end


#
# Populates your instance variables from the glade form.
# This works for Gtk:Button, Gtk::Entry, Gtk::Label and Gtk::Checkbutton.
# So instead of having to assign instance variable:
# 
# @example 
#    @name = @builder["name"].text 
#    @address = @builder["address"].text 
#    @eamil = @builder["email"].text 
#    @phone = @builder["phone"].text 
#    
# You can write one line of code:
# 
# @example   
#   get_glade_variables()
#    
# The optional parameter is seldom used because you usually want the
# glade form to populate from the calling class.  If you passed another object,
# the form would populate from it.
# @param [Object] obj Any object with instance variables with same names as in galde form.
# @return none 
  def get_glade_variables(obj = self)
    obj.instance_variables.each do |var_name|
      var = obj.instance_variable_get(var_name)
      var_name = var_name.to_s.gsub("@", "")  #fix for ruby 1.9 giving symbols
      if var.is_a? Hash
        var.each_pair do |key, val|
          if glade_value = get_control_value("#{var_name}[#{key.to_s}]")
            var[key] = glade_value
          end 
        end
        obj.instance_variable_set("@"+ var_name, var)
      elsif var.is_a? Array
        var.each_index do |i|
          if glade_value = get_control_value("#{var_name}[#{i.to_s}]")
            var[i] = glade_value
          end
        end
        obj.instance_variable_set("@"+ var_name, var)
      else
        glade_value = get_control_value(var_name)
        if glade_value
          obj.instance_variable_set("@"+ var_name, glade_value)
        end 
      end
    end
  end

  def get_control_value(glade_name)
    return unless control = @builder[glade_name]
    case control
      when Gtk::CheckButton then control.active?
      when Gtk::Entry then control.text
      when Gtk::TextView then control.buffer.text
      when Gtk::FontButton then control.font_name 
      when Gtk::ColorButton then control.color.to_s[0..2] + control.color.to_s[5..6] + control.color.to_s[9..10] 
      when Gtk::Label, Gtk::Button then control.label
      when Gtk::SpinButton, Gtk::Adjustment then control.value
      when Gtk::Image then control.file
      when Gtk::ProgressBar then control.fraction
      when Gtk::Calendar then DateTime.new(*control.date)
      when Gtk::ComboBoxText then control.active_text
    end  
  end

  def get_glade_active_record(obj) 
    return if not defined? @attributes
    obj.attributes.each_pair do |key, val|
      control = @builder[class_name(obj) + "." + key]
      control ||= @builder[key]
      case control
        when Gtk::CheckButton then self.send("#{key}=", control.active?)
        when Gtk::Entry then self.send("#{key}=", control.text)
        when Gtk::TextView then self.send("#{key}=", control.buffer.text)
        when Gtk::FontButton then self.send("#{key}=", control.font_name) 
        when Gtk::Label, Gtk::Button then self.send("#{key}=", control.label)
        when Gtk::SpinButton then self.send("#{key}=", control.value)
        when Gtk::Image then self.send("#{key}=", control.file)
        when Gtk::ProgressBar then self.send("#{key}=", control.fraction)
        when Gtk::Calendar then self.send("#{key}=", DateTime.new(*control.date))
        when Gtk::Adjustment then self.send("#{key}=", control.value)
      end   
    end
  end

# @private
  def self.included(obj)
    temp = caller[0].split(":") #correct for windows  C:\Users\george etc.
    caller_path_to_class_file, = temp[0].size == 1 ? temp[0] + ":" + temp[1] : temp[0] 
    obj.class_eval do
      define_method :my_class_file_path do
        return caller_path_to_class_file
      end
    end
  end



# The method you call to show the glade form.  
# It loads the glade form, sets all the form's widgets to your instance variables,
# connects all your methods to their signals, and starts Gtk.main loop if necessary.
# @param [Object #builder] parent  Optional parent that this window will always be on top of.
# @return nothing.
  def show_glade(parent = nil)
    load_glade()
    if parent then
        @builder[:window1].transient_for = parent.builder[:window1]
    end
    before_show() if respond_to? :before_show
    parse_signals()
    set_glade_all()
    @builder[:window1].show  #show_all can't hide widgets in before_show
    @top_level_window = Gtk.main_level == 0 ? true : false
    Gtk.main if @top_level_window or @builder[:window1].modal?  # need new Gtk.main for blocking!
  end

# Called when window is destroyed when you execute: <tt>@builder[:window1].destroy</tt>
# It manages the Gtk.main loop for all the windows.
  def window1__destroy(*args)
    Gtk.main_quit if @top_level_window or @builder["window1"].modal?  
  end

# Convenience method so you can just make a button named "buttonCancel" and it will work.  This
# method isn't called in code, its triggered by a user clicking a button named "buttonCancel".
  def buttonCancel__clicked(*a)
    @builder[:window1].destroy
  end

  def window1__key_press_event(view, evt)
    return unless evt.keyval == Gdk::Keyval::KEY_F8
    oinspect
  end

  # retrieves the key inside a glade control name.  Useful when handling events where
  # the control name is returned, and you need to match it to an actual hash.  
  # @example
  #   # Widget in glade form has name of "button[5]"
  #   var = @builder["button[5]"]
  #   extract_key(var) => "5"
  # @param [String] widget Name for the widget in the glade form.
  # @return [String] the key value.
  def extract_key(widget)
    widget.builder_name[/\[.+?\]/]
  end


#
#  private def active_record_valid?(show_errors = true)
#    get_glade_all
#    if not self.valid?
#      alset(self.errors.full_messages.join("\n\n")) if show_errors
#      self.reload
#      return false
#    end
#    return true
#  end


end


# Waits for all penting events to finish before continuing.
def clear_events()  
  while (Gtk.events_pending?)
    Gtk.main_iteration
  end
end
  
