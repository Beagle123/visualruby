load "./src/version.rb"

Gem::Specification.new do |s|
  s.name = "visualruby" 
  s.licenses = ["MIT"]
  s.version = VERSION   
  s.has_rdoc = false
  s.add_dependency('gtk3', '= 3.1.1')
  s.add_dependency('gtksourceview3', '= 3.1.1')
  s.add_dependency('require_all', '>= 1.2')
  s.authors = ["Eric Cunningham"]  
  s.email = "beagle4321_2000@yahoo.com" # optional 
  s.summary = "Create IDE designed to make great GUIs with Ruby" # optional
  s.homepage = "http://www.visualruby.net/"  # optional
  s.description = "Visualruby is a complete IDE for making graphical user interfaces with ruby.  It utilizes glade interface designer to create windows, and uses a library of GUI helpers to make coding GTK+ programs easy.  The IDE really helps you organize your files and your thoughts because it names your ruby files and glade files by a naming convention.  You files take on the names MyClass.rb, and MyClass.glade.  Then you can easily edit the GUI (glade file) by right clicking on your class's file.\n  It also creates .gemspec files for you, then you can right-click on the .gemspec file to install it, or upload it to rubygems.org.  You can also yank your gems with one click.\n\nTo install goto visualruby.net!" # optional
  s.executables = ['vr']  
  s.default_executable = 'vr'  
  s.bindir = ['.']    # optional, default = bin
  s.files = Dir.glob("./**/*.{rb,glade,png,yaml,sqlite3}", File::FNM_DOTMATCH) 
  s.rubyforge_project = "nowarning" # supress warning message 
end
