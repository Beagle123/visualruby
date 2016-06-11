
class RubygemsAPI 

	include GladeGUI

	CREDENTIALS_FILE = File.join(ENV['HOME'], ".gem", "credentials")

	def initialize
		uri = URI.parse("https://rubygems.org")
		@http = Net::HTTP.new(uri.host, uri.port)
		@http.use_ssl = true
  	@http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    load_glade()
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
    response_id = @builder["dialog1"].run  
    @builder["dialog1"].hide
    return unless response_id == 1    
    get_glade_all() #gets @username, @password
    begin
      @http.start() do |h|
        req = Net::HTTP::Get.new("/api/v1/api_key.yaml")
        req.basic_auth @username, @password
        response = h.request(req)
        obj = YAML.load(response.body)
        key = obj[:rubygems_api_key]
        if key
          File.open(CREDENTIALS_FILE,"w",0600) { |f| f.write(YAML.dump(obj)) } 
        else
          alert "Rubygems response:  \n" + obj.to_s
        end
      end
    rescue
      alert "Problem connecting to rubygems.org"
    end 
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
    unless key = get_key()
      return "No Rubygems Credentials" 
    end
    path = "https://rubygems.org/api/v1/gems"
    req = Net::HTTP::Post.new(path)	
    req.add_field('Authorization', key) 	
    req.content_type = 'application/octet-stream'
    bod = File.open(fn, "rb") {|io| io.read } # no good in win: File.open(fn).read
    req.body = bod #must do it like this to close io ??!?!
    req.content_length = req.body.size
    begin 
      @http.start() do |h|
        response = h.request(req)
        return response.message	
      end
    rescue
      alert "Problem connecting to rubygems.org"
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
