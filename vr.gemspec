
load "./src/version.rb"

Gem::Specification.new do |s|
  s.name = "visualruby" 
  s.licenses = ["MIT"]
  s.version = VERSION   
  s.add_dependency(GTK_VERSION) 
  s.add_dependency(GTK_SOURCEVIEW_VERSION) 
  s.add_dependency('require_all', '= 1.4')
  s.authors = ["Eric Cunningham"]  
  s.email = "beagle4321_2000@yahoo.com" # optional 
  s.summary = "Create IDE designed to make great GUIs with Ruby" # optional
  s.homepage = "https://github.com/Beagle123/visualruby"  # optional
  s.description = "Visualruby is a complete IDE for making graphical user interfaces with ruby.  It utilizes glade interface " +
            "designer to create windows, and uses a library of GUI helpers to make coding GTK+ programs easy.  " +
            "The IDE really helps you organize your files and your thoughts because it names your ruby files and glade " +
            "files by a naming convention.  You files take on the names MyClass.rb, and MyClass.glade.  Then you can easily " +
            "edit the GUI (glade file) by right clicking on your class's file.\n  It also creates .gemspec files for you, then " +
            "you can right-click on the .gemspec file to install it, or upload it to rubygems.org.  You can also yank your " +
            "gems with one click.\n\nTo install, get instructions from our github page at https://github.com/Beagle123/visualruby" 
  s.executables = ['vr']   
  s.bindir = ['.']    # optional, default = bin
  s.files = Dir.glob("./**/*.{rb,glade,png,yaml,sqlite3}", File::FNM_DOTMATCH) 
  s.files << "vr"
end
