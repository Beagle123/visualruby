module VR_Tools

  def VR_Tools.clear_events
    while (Gtk.events_pending?)
      Gtk.main_iteration
    end
  end

  def VR_Tools.popen(cmd)
    begin
      IO.popen(cmd)
    rescue
      alert("The following command couldn't run:\n\n<b>#{cmd}</b>\n\nCheck the path in Tools > Settings." + 
          "\n\nIn MS Windows you may need to add the 'start' command i.e. <b>'start glade'</b>")
    end
  end



  def VR_Tools.back_up()
    path = File.join(ENV["HOME"], "visualruby_backup", Dir.pwd.gsub(ENV["HOME"], ""))
    t = Time.now
    out_dir = path + "/" + Dir.pwd.split("/").last + " Backup " + t.month().to_s + '-' + t.day().to_s + "-" + t.year().to_s + " at " + t.strftime('%I %M%p')  
    copy_recursively(Dir.pwd, out_dir) 
    alert "Files backed up to:  \n\n" + path 
  end

  def VR_Tools.copy_skeleton_project(path)
      VR_Tools.copy_recursively(File.dirname(__FILE__) + "/../../skeleton/project", path)
  end

  def VR_Tools.copy_recursively(from, out_dir)
    Find.find(from) do |path|
      next if path == from
      rel_path = path.gsub(from, "")
      if File.directory?(path) 
        FileUtils.makedirs(out_dir + rel_path)   
      else
        if not File.directory?(out_dir + File.dirname(rel_path))
          FileUtils.makedirs(out_dir + File.dirname(rel_path))
        end
        FileUtils.copy(path, out_dir + rel_path)
      end
    end
  end
 
  def self.create_gemspec()
    main_file = $VR_ENV.run_command_line.split(" ")[1]
    main_path = "."
    bindir = "'.'" #( main_path == "bin") ? "'bin'" : "'#{main_path}', 'bin'" 
    libdir = "'.'" #(main_path == "lib") ? "'lib'" : "'#{main_path}', 'lib'"
    str = <<END
Gem::Specification.new do |s|
  s.name = "#{File.basename(Dir.pwd).downcase}"  # i.e. visualruby.  This name will show up in the gem list.
  s.version = "0.0.1"  # i.e. (major,non-backwards compatable).(backwards compatable).(bugfix)
  s.add_dependency "vrlib", ">= 0.0.1"
  s.add_dependency "gtk2", ">= 0.0.1"
  s.add_dependency "require_all", ">= 0.0.1"
  s.has_rdoc = false
  s.authors = ["Your Name"] 
  s.email = "you@yoursite.com" # optional
  s.summary = "Short Description Here." # optional
  s.homepage = "http://www.yoursite.org/"  # optional
  s.description = "Full description here" # optional
  s.executables = ['#{main_file}']  # i.e. 'vr' (optional, blank if library project)
  s.default_executable = '#{main_file}'  # i.e. 'vr' (optional, blank if library project)
  s.bindir = [#{bindir}]    # optional, default = bin
  s.require_paths = [#{libdir}]  # optional, default = lib 
  s.files = Dir.glob(File.join("**", "*.{rb,glade}"))
  s.rubyforge_project = "nowarning" # supress warning message 
end
END
    name =  File.basename(Dir.pwd).downcase + ".gemspec"
    if File.file?(name)
      unless alert("Do you want to overwrite existing file?:\n<b>#{name}</b>?", 
            :headline => "File Already Exists", :button_yes => "Overwrite", :button_no => "Cancel", :width => 400)
        return false
      end
    end
    file_name = File.join(Dir.pwd,name)
    File.open(file_name, "w") { |f| f.puts(str) }
    return file_name
  end
  #
  #this works on Dir.pwd that's maybe different from project
  def VR_Tools.replace_html_in_docs()
    return if not File.file? "vrlib/rdoc_replace.yaml"
    ar = YAML.load_file "vrlib/rdoc_replace.yaml"  
    Dir.glob("#{Dir.pwd}/doc/**/*.html") do |f|
      str = File.open(f).read
      ar.each do |pair|
        str.gsub!(pair[0], pair[1])
      end
      File.open(f, "w") { |file| file.puts(str) }
    end
#    FileUtils.cp "#{Dir.pwd}/rdoc.css", "#{Dir.pwd}/doc/rdoc.css" if File.file?("#{Dir.pwd}/rdoc.css") and File.directory?("#{Dir.pwd}/doc")
  end

end
#  def VR_Tools.sudo_command(command)
#    @pass ||= ""
#    if @pass.strip() == ""
#      @pass = VR::Dialog.input_box("Enter System Password:")
#    end
#    result = command + "\n" + `echo #{@pass} | sudo -S #{command}`
#    @pass = "" if result.include? "incorrect password"
#    return result 
#  end

#  def VR_Tools.create_desktop_launcher()
#    command = "vr " + Dir.pwd
#    name = File.basename(Dir.pwd) + " Project" 
#      str = <<END
#
##!/usr/bin/env xdg-open
#
#[Desktop Entry]
#Version=1.0
#Type=Application
#Terminal=false
#Icon[en_US]=gnome-panel-launcher
#Name[en_US]=#{name}
#Exec=#{command}
#Comment[en_US]=Opens a Visual Ruby project
#Name=#{name}
#Comment=Opens a Visual Ruby project
#Icon=gnome-panel-launcher
#
#END
#    return unless File.directory?(ENV["HOME"] + "/Desktop")
#    fn = ENV["HOME"] + "/Desktop/" + name + ".desktop"
#    File.open(fn,"w") { |f| f.puts(str) }
#    File.chmod(0755, fn)
#    alert("Created launcher:\n" + name + "\non your computer's desktop")
#  end

