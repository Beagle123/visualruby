

require "vrlib"

require_relative 'src/MainApp'
require_relative 'src/SavableSettings'

# load class from settings.yaml
env = VR::load_yaml(SavableSettings, "settings.yaml")

# show it
env.show_glade()
