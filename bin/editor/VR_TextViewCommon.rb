module VR_TextViewCommon

	def get_line_text(line)
		return nil if line > buffer.line_count - 1
		iter, iter_end = get_line_iters(line)
		return buffer.get_text(iter, iter_end, false)
	end

	def get_line_iters(line, search_str = nil)
		s = buffer.get_iter_at(:line => line)
		e = get_end_iter(s)
		if !search_str.nil?
# depricated			s, e = s.forward_search(search_str, Gtk::TextIter::SEARCH_TEXT_ONLY, e)
		s, e = s.forward_search(search_str, :text_only, e)
		end
		return s, e
	end

	def select_text(line, search_str = nil)
			s, e = get_line_iters(line, search_str)
    	buffer.move_mark(buffer.get_mark("insert"),s)
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
		return iter.line-1
	end

	def scroll_to_cursor()
   	os = buffer.cursor_position
		return if os > buffer.char_count - 1 or os == 0
		iter = buffer.get_iter_at(:offset => os)  #get_iter_at_offset depricated
		scroll_to_iter(iter, 0.0, true, 1.0, 0.5)
	end

end
