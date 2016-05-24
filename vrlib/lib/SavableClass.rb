class VR::SavableClass

	def initialize(filename = nil)
		@filename = filename 
		defaults		
	end

	def self.load_yaml(filename)
		if File.file?(filename) 
		 	me = YAML.load(File.open(filename).read)
			me.filename = filename
			me.defaults()
			return me 
		else
	   return nil
		end
	end

	def save_yaml(new_filename = nil)
		@filename = new_filename if new_filename
		data = YAML.dump(self)
		File.open(@filename, "w") {|f| f.puts(data)}
	end


end
