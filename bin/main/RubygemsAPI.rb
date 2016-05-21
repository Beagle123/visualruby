
class RubygemsAPI 

	include GladeGUI

	CREDENTIALS_FILE = ENV['HOME'] + "/.gem/credentials"

	def initialize
		uri = URI.parse("https://rubygems.org")
		@http = Net::HTTP.new(uri.host, uri.port)
		@http.use_ssl = true
  	@http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	end
  
	def get_key()
		if File.file?(CREDENTIALS_FILE)
			return Gem.configuration.rubygems_api_key
		end
		return set_up_key()
	end

	def set_up_key()
		@username = ""
		@password = ""
		key = nil
		set_glade_all()
		@builder["dialog1"].run do |response_id|
			if response_id == 1 #Ok Button
    		get_glade_all() #gets @username, @password
    		path = "/api/v1/api_key.yaml"
    		@http.start() do |h|
        	req = Net::HTTP::Get.new(path)
        	req.basic_auth @username, @password
      		response = h.request(req)
      		obj = YAML.load(response.body)
      		key = obj[:rubygems_api_key]
					if key
      			File.open(CREDENTIALS_FILE,"w",0600) { |f| f.write(YAML.dump(obj)) }
					else
						VR::msg(obj.values[0])
					end 
				end
			end
		end
		@builder["dialog1"].hide
		return key
	end


	def get_obj_url(path)
		return nil unless key = get_key()
		@http.start() {|h|
      req = Net::HTTP::Get.new(path)
			response = h.request_get(path, 'Authorization' => key)
			return obj = YAML.load(response.body)	
    }
	end


# in Windows, the File.open { read } doesn't work for the gemfile.
# also, you must set a variable (bod) to close the io stream

	def push_gem(fn)
    return unless key = get_key()
    path = "https://rubygems.org/api/v1/gems"
    req = Net::HTTP::Post.new(path)	
    req.add_field('Authorization', key) 	
    req.content_type = 'application/octet-stream'
    bod = File.open(fn, "rb") {|io| io.read } # no good in win: File.open(fn).read
    req.body = bod #must do it like this to close io ??!?!
    req.content_length = req.body.size
    @http.start() do |h|
      response = h.request(req)
      return response.message	
    end
	end

	def yank_gem(name, ver)
    return unless key = get_key()
    path = "/api/v1/gems/yank?gem_name=#{URI.encode(name)}&version=#{URI.encode(ver)}"
    req = Net::HTTP::Delete.new(path)		
    req.add_field('Authorization', key) 
    req.add_field 'Connection', 'keep-alive'
    req.add_field 'Keep-Alive', '30'
    req.content_type = 'application/x-www-form-urlencoded'
    @http.start() do |h|
      response = h.request(req)
      return response.message	
    end
    end
	
end
