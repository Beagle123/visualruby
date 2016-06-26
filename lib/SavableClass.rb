module VR

  def self.load_yaml(flags)
    me = nil
    if File.file?(flags[:file_name]) 
      me = YAML.load(File.open(flags[:file_name]).read)
    elsif flags[:class]
      me = flags[:class].new()
    end
    file_name = File.expand_path(flags[:file_name])
    me.instance_variable_set(:@vr_yaml_file, file_name)
    me.defaults() if me.respond_to?(:defaults)
    VR::save_yaml(me)
    return me
  end

  # todo create folders if don't exist
  def self.save_yaml(obj, filename = nil)
    filename ||= obj.instance_variable_get(:@vr_yaml_file) 
    dirname = File.dirname(filename)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    File.open(filename, "w") {|f| f.puts(obj.to_yaml)}
  end

end

#
#class VR::SavableClass
#
#  def initialize(filename = nil)
#    @filename = filename 
#    defaults    
#  end
#
#  def self.load_yaml(filename)
#    if File.file?(filename) 
#       me = YAML.load(File.open(filename).read)
#      me.filename = filename
#      me.defaults()
#      return me 
#    else
#     return nil
#    end
#  end
#
#  def save_yaml(new_filename = nil)
#    @filename = new_filename if new_filename
#    data = YAML.dump(self)
#    File.open(@filename, "w") {|f| f.puts(data)}
#  end
#
#
#end





