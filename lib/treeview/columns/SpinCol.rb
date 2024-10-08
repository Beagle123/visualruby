
#  This column signals VR::TreeView to make a column that appears as a number
#  and uses a spinbutton to edit it.

module VR::Col

  class SpinCol < Gtk::Adjustment

    def initialize(val, min, max, step)
      super(val, min, max, step, 0, 0)
    end

  end

end
