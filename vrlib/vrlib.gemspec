Gem::Specification.new do |s|
  s.name = "vrlib"  # i.e. visualruby.  This name will show up in the gem list.
  s.version = "3.0.0"  # i.e. (major,non-backwards compatable).(backwards compatable).(bugfix)
	s.has_rdoc = false
	s.licenses = ["MIT"]
	s.add_dependency('require_all', '>= 1.2')
	s.add_dependency('gtk3', '>= 3.0')	
  s.authors = ["Eric Cunningham"] 
  s.email = "eric@visualruby.net" # optional
  s.summary = "Library to make GUIs with Ruby" # optional
  s.homepage = "http://www.visualruby.net/"  # optional
  s.description = "Library to make GUIs with Ruby.  This library is a dependency of visualruby.  This library is useful in the context of visualruby.  Go to visualruby.net to download visualruby." # optional
	s.executables = ['']  # i.e. 'vr' (optional, blank if library project)
	s.default_executable = ''  # i.e. 'vr'  This is what you type on the command line.
#	s.bindir = ['bin']    # optional, default = bin
	s.require_paths = [".",'lib']  # optional, default = lib 
	s.files = Dir.glob(File.join("**", "*.{rb,glade,png}")) << "vrlib.rb"
puts s.files.to_s
	s.rubyforge_project = "nowarning" # supress warning message 
end
