
module VR

  class ImageCol #< Gdk::Pixbuf

    include GladeGUI
 
    def initialize(image)
#      super(File.dirname(__FILE__) + "/../../../img/image-x-generic.png")
      @image1 = image
    end

    def before_show()
      @builder["window1"].resize 500, 360
    end

    def to_s
      "<Img>"
    end

#    def visual_attributes
#      { :pixbuf => self }
#    end

  end

end
