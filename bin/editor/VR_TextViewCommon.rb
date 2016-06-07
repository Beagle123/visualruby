module VR_TextViewCommon

	def get_line_iters(line, search_str = nil)
		s = buffer.get_iter_at(:line => line)
		e = get_end_iter(s)
		if !search_str.nil?
		s, e = s.forward_search(search_str, :text_only, e)
		end
		return s, e
	end

	def select_text(line, search_str = nil)
			s, e = get_line_iters(line, search_str)
			return if s.nil? or e.nil?
      buffer.place_cursor(s)
#    	buffer.move_mark(buffer.get_mark("insert"),s)
			buffer.move_mark(buffer.get_mark("selection_bound"), e)
	end


	def apply_tag_to_line(line, tag, search_str = nil)
			s, e = get_line_iters(line, search_str)
			buffer.apply_tag(tag, s, e)	
	end

	

	def get_end_iter(iter)
    if iter.line == buffer.line_count - 1 # last line
      return buffer.end_iter 
    end
    return buffer.get_iter_at(:line => iter.line+1)
	end
	
	def remove_tag(tag)
		s, e = buffer.bounds
		buffer.remove_tag(tag, s, e)	
	end

	def line_at_cursor()
    cursor_pos = buffer.cursor_position
    iter = buffer.get_iter_at(:offset => cursor_pos)  #get_iter_at_offset depricated
		return iter.line + 1
	end

end
