Gem::Specification.new do |s|
  s.name = "visualruby"  # i.e. visualruby.  This name will show up in the gem list.
	s.licenses = ["MIT"]
  s.version = "3.0.0"   
	s.has_rdoc = false
#	s.add_dependency('rdoc')
	s.add_dependency('vrlib', '>=3.0.0') # for examples
	s.add_dependency('gtksourceview3', '>= 3.0.0')
  s.authors = ["Eric Cunningham"] 
  s.email = "eric@visualruby.net" # optional
  s.summary = "Create IDE designed to make great GUIs with Ruby" # optional
  s.homepage = "http://www.visualruby.net/"  # optional
  s.description = "Visualruby is a complete IDE for making graphical user interfaces with ruby.  It utilizes glade interface designer to create windows, and uses a library of GUI helpers to make coding GTK+ programs easy.  The IDE really helps you organize your files and your thoughts because it names your ruby files and glade files by a naming convention.  You files take on the names MyClass.rb, and MyClass.glade.  Then you can easily edit the GUI (glade file) by right clicking on your class's file.\n  It also creates .gemspec files for you, then you can right-click on the .gemspec file to install it, or upload it to rubygems.org.  You can also yank your gems with one click.\n\nTo install goto visualruby.net!" # optional
	s.executables = ['vr']  # i.e. 'vr' (optional, blank if library project)
	s.default_executable = 'vr'  # i.e. 'vr'  This is what you type on the command line.
	s.require_paths = ['vrlib']  # optional, default = lib 
	s.bindir = ['.']    # optional, default = bin
#	s.require_paths = ['lib']  # optional, default = lib
	s.files = Dir.glob("./**/*.{rb,glade,png,yaml,sqlite3}")
#	s.files = s.files + Dir.glob(File.join("bin", "**", "*.{rb,glade,png,yaml}"))
#	s.files = s.files + Dir.glob(File.join("lib", "**", "*.{rb,glade,png,yaml}"))
#	s.files = s.files + Dir.glob(File.join("img", "**", "*.{rb,glade,png,yaml}"))
#	s.files = s.files + Dir.glob(File.join("vrlib/lib", "**", "*.{rb,glade,png,yaml}"))
#	s.files = s.files + Dir.glob(File.join("skeleton", "**", "*.{rb,glade,png,yaml}"))
#	s.files = s.files + Dir.glob(File.join("examples", "simple_ruby_gui", "**", "*.{rb,glade,png,}"))
#	s.files = s.files + Dir.glob(File.join("examples", "simple_ruby_gui", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "simple_ruby_gui", "simple_ruby_gui"))
#	s.files = s.files + Dir.glob(File.join("examples", "calculator", "**", "*.{rb,glade,png}"))
#	s.files = s.files + Dir.glob(File.join("examples", "calculator", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "child_window", "**", "*.{rb,glade,png}"))
#	s.files = s.files + Dir.glob(File.join("examples", "child_window", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "listview", "**", "*.{rb,glade,png}")) 
#	s.files = s.files + Dir.glob(File.join("examples", "listview", ".vr_settings.yaml")) 
#	s.files = s.files + Dir.glob(File.join("examples", "all_widgets", "**", "*.{rb,glade,png}"))
#	s.files = s.files + Dir.glob(File.join("examples", "all_widgets", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "listview_objects", "**", "*.{rb,glade,png}"))
#	s.files = s.files + Dir.glob(File.join("examples", "listview_objects", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "active_record", "**", "*.{rb,glade,png,sqlite3}"))
#	s.files = s.files + Dir.glob(File.join("examples", "active_record", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "active_record2", "**", "*.{rb,glade,png,sqlite3}"))
#	s.files = s.files + Dir.glob(File.join("examples", "active_record2", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "drag_drop", "**", "*.{rb,glade,png}"))
#	s.files = s.files + Dir.glob(File.join("examples", "drag_drop", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "treeview", "**", "*.{rb,glade,png}"))
#	s.files = s.files + Dir.glob(File.join("examples", "treeview", ".vr_settings.yaml"))
#	s.files = s.files + Dir.glob(File.join("examples", "alert_box", "**", "*.{rb,glade,png}"))
#	s.files = s.files + Dir.glob(File.join("examples", "alert_box", ".vr_settings.yaml"))
	s.rubyforge_project = "nowarning" # supress warning message 
end
