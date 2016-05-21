
class VR_TextShell < Gtk::TextView

	include VR_TextViewCommon

	def initialize(tabs)
		super()
		@tabs = tabs
		@current_line = 0
		@lines = [] #needed
		self.editable = false
		@blue = buffer.create_tag("blue", { "foreground" => "#0000A0", "underline" => Pango::UNDERLINE_SINGLE  })
		@hilight = buffer.create_tag("hilight", { "background" => "#FFF0A0" } )
		signal_connect("button_release_event") { jump_to(line_at_cursor() +1) }  #buffer's lines start at 1  
		signal_connect("key_release_event") { jump_to(line_at_cursor() +1) }  #buffer's lines start at 1  
#		self.buffer.signal_connect("changed") { buffer__changed() }
	end

# @buffer.signal_connect("changed") {
#      eob_mark = 
#@output.buffer.create_mark(nil,@output.buffer.start_iter.forward_to_end,false)
#      @output.scroll_mark_onscreen(eob_mark)
#    }

	def buffer__move_cursor
		remove_tag(@hilight)
#		place_cursor_onscreen
		line = line_at_cursor()
		apply_tag_to_line(line, @hilight)
	end


	def hilight_links(text, jump_to_first)
		self.buffer.text = text
		first_valid_line = load_lines()
		(0..@lines.size - 1).each do |i|
			next if @lines[i].nil?
			apply_tag_to_line(i, @blue, @lines[i][:file_name] + ":" + @lines[i][:line].to_s)
		end
		@current_line = 0
		@tabs.jump_to(first_valid_line) if jump_to_first and first_valid_line
	end



	def load_lines()
		@lines = []
		first = nil
		reg = /^.*(#{Dir.pwd}[\w+|\/]*)\/([\w|\.]+):(\d+):/ 
		reg_str =  /Found:\s(.+)$/
		self.buffer.text. each_line do |l|
			m = reg.match(l)
			if m.nil?
				@lines << nil
			else 
				m2 = reg_str.match(l)
				search_str = (m2.nil?) ? "" : m2[1]   
				@lines << { :path => m[1] + "/" + m[2], :file_name =>  m[2], :line =>  m[3].to_i, :search_str => search_str }
				first ||= @lines.last 
			end				
		end
		return first
	end
	
	def jump_to(line_no = @current_line+1)
		return false if line_no > @lines.size - 1
		@current_line = line_no
		remove_tag(@hilight)
		apply_tag_to_line(@current_line, @hilight, nil)
		@tabs.jump_to(@lines[@current_line])
		return false #must return false for button_up event
	end

end
