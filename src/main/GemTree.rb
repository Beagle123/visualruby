
class GemTree < VR::ListView

  RUBY_ICON = GdkPixbuf::Pixbuf.new(:file => File.dirname(__FILE__) + '/../../img/rb.png')

  def initialize()
    hash = {:gems => {:pix => GdkPixbuf::Pixbuf, :gem => String}}
    super(hash)
    self.headers_visible = false
    @api = RubygemsAPI.new
  end

  def self__button_release_event(w, event)
    return unless selection.selected and event.button == 3 #right mouse
    @builder['popGem'].popup(nil, nil, event.button, event.time)
  end

  def get_name_ver(line)
    match = /^(.*)\s+\((.*)\)/.match(line)
    return match[1], match[2]
  end

end
