class ModalWindow

  include GladeGUI

  def buttonOk__clicked(*argv)
    @builder["window1"].close
  end

end
