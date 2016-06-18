module VR

  class SpinCol < Gtk::Adjustment

    def initialize(val, min, max, step)
      super(val, min, max, step, 0, 0)
    end

  end

end
