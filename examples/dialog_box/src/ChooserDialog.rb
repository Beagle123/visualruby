
class ChooserDialog
 
  include GladeGUI

  def run()
    load_glade
    response = @builder[:window1].run()
    @builder[:window1].hide
    case response
      when Gtk::ResponseType::OK
        return @builder[:comboLang].active_text, @builder[:checkDefault].active?
      when Gtk::ResponseType::CANCEL
        return nil, nil
    end  
  end

end

