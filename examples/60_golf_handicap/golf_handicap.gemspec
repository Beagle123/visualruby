Gem::Specification.new do |s|
  s.name = "golf_handicap"  # i.e. visualruby.  This name will show up in the gem list.
  s.version = "0.0.11"  # i.e. (major,non-backwards compatable).(backwards compatable).(bugfix)
  s.add_dependency "visualruby"
  s.has_rdoc = false
  s.authors = ["Eric Cunningham"] 
  s.email = "you@yoursite.com" # optional
  s.summary = "Calculates your USGA handicap." # optional
  s.homepage = "http://visualruby.net/"  # optional
  s.description = "Calculates your USGA handicap.  Just enter your scores, and this calculator will calculate your golf handicap index using the exact formula that the USGA uses."   
  s.executables = ['golf_handicap']  # i.e. 'vr' (optional, blank if library project)
  s.default_executable = 'golf_handicap'  # i.e. 'vr' (optional, blank if library project)
  s.bindir = ['.']    # optional, default = bin
  s.require_paths = ['lib']  # optional, default = lib 
  s.files = Dir.glob(File.join("**", "*.{rb,glade}"))
  s.rubyforge_project = "nowarning" # supress warning message 
end
