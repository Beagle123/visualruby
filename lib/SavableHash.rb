
module VR

  class SavableHash < Hash
    
    def init(arg) #either file path or defaults hash
#       if File(arg[:file]).exists
#         return YAML.load(File.open(arg[:file]).read)
#       else
        arg
#       end 
    end

    def save()
      file = self[:file]
alert file
      File.open(file, "w") {|f| f.puts(self.to_yaml)}
    end
    

  end

end


