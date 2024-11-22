
class BuilderDemo 
 
  include GladeGUI

  # You can retreive the @builder objects:
  def ui_change_but__clicked(*args) 
    if @builder["ui_animal_ent"].buffer.text == "Dog"
      @builder["ui_animal_ent"].buffer.text = "Cat"
      @builder["ui_name_ent"].buffer.text = "Fluffy"
    else # use variables instead 
      @builder["ui_animal_ent"].buffer.text = "Dog"
      @builder["ui_name_ent"].buffer.text = "Puddles"   
    end
  end


end

