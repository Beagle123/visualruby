
class DataObjectGUI 

  include GladeGUI
    
  # the @init_ variables are just saving the initial values for reset
  def initialize(name, address, phone, email)
    @ui_name_ent    = @init_name    = name
    @ui_address_ent = @init_address = address 
    @ui_phone_ent   = @init_phone   = phone
    @ui_email_ent   = @init_email   = email
  end  

  def before_show()
    show_values
  end

  # call get_glade_variables
  def ui_getglade_but__clicked(*args)
    get_glade_variables
    show_values
  end

  # don't call get_glade_variables
  def ui_show_variables_but__clicked(*args)
    show_values
  end

  # reset to initial values
  def ui_setglade_but__clicked(*args)
    @ui_name_ent = @init_name
    @ui_address_ent = @init_address 
    @ui_phone_ent = @init_phone
    @ui_email_ent = @init_email
    set_glade_variables
    show_values 
  end

  def show_values
    @builder[:ui_var_txt].buffer.text = "Variable Values:\n" + 
      "@ui_name_ent = #{@ui_name_ent}\n" +
      "@ui_address_ent = #{@ui_address_ent}\n" +
      "@ui_email_ent = #{@ui_email_ent}\n" +
      "@ui_phone_ent = #{@ui_phone_ent}" 
  end
  

end

