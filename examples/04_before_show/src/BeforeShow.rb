
class BeforeShow
 
  include GladeGUI

  def initialize()
    if @bilder.nil?
      alert("Inside initialize():\n@builder = nil")
    end
  end

  # in before_show() you can use @builder
  def before_show()
    my_button = @builder["ui_button"]
    my_button.label = "Hello World"
    @builder["ui_entry"].text = "This was put here by before_show()"
  end  


end

