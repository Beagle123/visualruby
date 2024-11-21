
class BuilderDemo 
 
  include GladeGUI
  
  def initialize()
    if @builder.nil?
      alert("Inside initialize:  \n@builder doesn't exist yet!")
    end
  end

  def before_show()
    alert("Inside before_show():\n @builder = #{@builder.class.to_s}")
    @builder["ui_change_but"].label = "Change Animal"

    # assign variables as a shortcut to objects in @builder:
    @name_buf = @builder["ui_name_ent"].buffer
    @animal_lbl = @builder["ui_animal_lbl"] 
  end  

  # You can retreive the @builder objects, or use the variables:
  def ui_change_but__clicked(*args)  #use @builder directly
    if @builder["ui_animal_lbl"].label == "Dog"
      @builder["ui_animal_lbl"].label = "Cat"
      @builder["ui_name_ent"].buffer.text = "Fluffy"
    else # use variables instead 
      @animal_lbl.label = "Dog"
      @name_buf.text = "Puddles"    
    end
  end

  def ui_show_but__clicked(*args)
    alert @builder["ui_name_ent"].text  # same as @name_buf.text
  end

end

