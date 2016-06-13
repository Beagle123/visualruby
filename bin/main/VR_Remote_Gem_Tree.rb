class VR_Remote_Gem_Tree < GemTree

  include GladeGUI

  def initialize(main)
    super()
    @main = main
    @gems = Hash.new
#    load_glade()  #for pop-up menu
#    parse_signals()
  end

  def refresh(force = true)
    return if @t
    return unless force or not self.model.iter_first
    return unless @api.get_key()
    @t = Thread.new do 
      @main.shell.buffer.text += "\nContacting rubygems.org..." 
      self.model.clear
      return unless @gems = @api.get_obj_url("/api/v1/gems.yaml")
      @gems.each do |gem|
        gem_info = @api.get_obj_url("/api/v1/versions/#{gem['name']}.yaml")
        gem_info.each do |info|
          self.add_row(:pix => RUBY_ICON, :gem => "#{gem['name']} (#{info['number']})") 
        end
      end
      @t.join
    end
    @t = false
  end

  def selected_gem
    row = self.selection.selected[1].split(" (")
    @gems.detect { |gem| gem['name'] == row[0] } #and gem['version'] == ver}
  end

  def popOpenRubygemsPage__activate(*args)     
    gem = selected_gem()
    VR_Tools.popen("#{$VR_ENV_GLOBAL.browser} #{gem['project_uri']}")
   end

  def popOpenHomepage__activate(*args) 
    gem = selected_gem()
    VR_Tools.popen("#{$VR_ENV_GLOBAL.browser} #{gem['homepage_uri']}")
   end

  def popYank__activate(*args)
    name, ver = get_name_ver(selection.selected[1])
    reply = @api.yank_gem(name, ver)
    @main.shell.buffer.text = "Yanking gem: #{name} #{ver}\n" + reply
    self.model.remove(selection.selected) if reply.include? "OK"
  end

end



