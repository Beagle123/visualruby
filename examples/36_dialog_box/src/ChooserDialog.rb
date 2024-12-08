
class ChooserDialog
 
  include GladeGUI  # to load ChooserDialog.glade

  def run()
    load_glade  # in GladeGUI
    response = @builder[:window1].run()
    case response
      when Gtk::ResponseType::OK
        lang, default = @builder[:comboLang].active_text, @builder[:checkDefault].active?
      when Gtk::ResponseType::CANCEL
        lang, default = nil, nil
    end 
    @builder[:window1].close
    return lang, default 
  end

end

