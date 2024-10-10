
require "vrlib"
require_relative "src/Handicap"
require_relative "src/LoadGolfer"
require_relative "src/Score"

last_file = Dir.glob("*.yaml").max_by {|f| File.mtime(f)}

if last_file.nil?
  load_new_golfer
else
  VR::load_yaml(Handicap, last_file).show_glade
end





