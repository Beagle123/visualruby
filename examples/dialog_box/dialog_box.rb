
require "vrlib"

require_relative "src/ChooserDialog"

dialog = ChooserDialog.new()
language, set_default = dialog.run()
alert("Language:  #{language}\nSet Default?: #{set_default ? 'true' : 'false'}") unless language.nil?



