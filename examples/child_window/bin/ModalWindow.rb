class ModalWindow

	include GladeGUI

	def buttonOk__clicked(*argv)
		@builder["window1"].destroy
	end

end
