
class SplashWindow < Gtk::Window

  def initialize()
    super()
    self.decorated = false
    img = Gtk::Image.new(file: File.join($root, "img", "splash.png"))
    img.visible = true
    self.set_child(img)
#    self.set_position(:center)
    self.position = :center_always
    self.set_keep_above(true)
    self.position = :center_always
# puts File.join("..", "..", "img", "splash.png")

  end

end
