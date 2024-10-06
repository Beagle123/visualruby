
class ChoosePerson < VR::ListView

  include GladeGUI

  def initialize()
    super(:person => Person)  # Person class
  end

  def before_show()
    @builder["scrolledwindow1"].add(self)
    Person.all.each do |p|
      row = add_row(:person => p)
    end
    self.show
  end

  def buttonShow__clicked(*a)
    return unless row = selected_rows.first
    row[:person].show_glade()
  end


end
