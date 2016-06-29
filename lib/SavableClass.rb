module VR

  # Loads or creates a yaml file with a given object type (class).
  # If the file exists already, the object will be returned. If not,
  # a new instance will be returned, and the file will instantly be saved.
  # @param [Class] klass The class of the object to be loaded or created
  # @param [String] file_name File name to save.  Should be named .yaml
  # @param [Splat] args Optional arguments to pass to contructor of class.  Not used often.
  # @return [Object] Object of type klass that was loaded or created.
  def self.load_yaml(klass, file_name, *args)
    me = nil
    if File.file?(file_name) 
      me = YAML.load(File.open(file_name).read)
    else 
      me = klass.new(*args)
    end
    file_name = File.expand_path(file_name)
    me.instance_variable_set(:@vr_yaml_file, file_name)
    me.defaults() if me.respond_to?(:defaults)
    VR::save_yaml(me)
    return me
  end

  # Saves an object likely loaded with #load_yaml to disk.
  # @param [Object] obj Object to save in yaml format
  # @param [String] file_name Optional file name to save yaml file to.  When omitted, 
  #   it will save file to path where it was opened from.  Only supply this param if you want to
  #   make another copy of the yaml file.
  def self.save_yaml(obj, file_name = nil)
    file_name ||= obj.instance_variable_get(:@vr_yaml_file)
    dir = File.dirname(file_name)
    unless File.directory?(dir)
      FileUtils.mkdir_p(dir) 
    end
    File.open(file_name, "w") {|f| f.puts(obj.to_yaml)}
  end
  # Note: can't remove @builder or @top_level_window variables because needed to close window.
end

   
