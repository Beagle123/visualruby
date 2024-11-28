
class Find_Replace

  include GladeGUI

  def initialize(tabs, shell)
    @tabs = tabs
    @shell = shell
    @entryFind = @tabs.docs[@tabs.page].selected_text()
    @entryReplace = nil
    @checkCase = true
    @comboFiles = "All Files in Project"
  end

  def buttonNext__clicked(*a)
    get_glade_variables
    return if @entryFind.length < 2
    if @comboFiles == "All Files in Project"
      text = @tabs.find_in_all(@entryFind, @checkCase) 
      @shell.hilight_links(text, false)
    else
      move(@tabs.docs[@tabs.page], :forward) # name of method to use
    end
  end

  def buttonPrevious__clicked(*a)
    return if @entryFind.length < 2
    move(@tabs.docs[@tabs.page], :backward)
  end
  
  def move(page, direction, called_by_self = false)
    get_glade_variables
    @skipped_pages = called_by_self ? @skipped_pages + 1 : 0
    if @skipped_pages > @tabs.docs.length
      return
    end
    page.context.set_highlight(true)
    page.settings.set_case_sensitive(@checkCase) 
    page.settings.set_search_text(@entryFind)
    cursor_iter = page.buffer.get_iter_at(:offset => page.buffer.cursor_position + 1)
    found, start_iter, end_iter, wrapped = page.context.send(direction, cursor_iter)
    if found
      page.hilight_selection(start_iter, end_iter) 
    elsif @comboFiles == "All Open Documents" 
      if direction == :forward
        next_page = @tabs.page == @tabs.docs.length-1 ?  0 : @tabs.page + 1 
      else
        next_page = @tabs.page == 0 ? @tabs.docs.length-1 : @tabs.page - 1
      end  
      @tabs.page = next_page
      page = @tabs.docs[@tabs.page]
      iter = direction == :forward ? page.buffer.start_iter : page.buffer.end_iter
      page.buffer.place_cursor(iter)
      move(page, direction, true)
    else
      alert "End of Document"  
    end
  end

  def buttonReplace__clicked(*a)
    page = @tabs.docs[@tabs.page]
    return unless page.buffer.has_selection?
    s,e = page.buffer.selection_bounds
    page.buffer.delete(s,e)
    page.buffer.insert_at_cursor(@builder[:entryReplace].text)
#     page.context.replace(s, e, @builder[:entryReplace].text, @builder[:entryReplace].text.length)  #doesn't work after clicking shell to find match
  end

  def buttonReplaceAll__clicked(*a)
    total = 0
    get_glade_variables
    return unless alert("This will replace:  <b>#{@entryFind}</b> with <b>#{@entryReplace}</b>\nIn these files:  <b>#{@comboFiles}</b>\n",
         headline: "Do You Wish to Continue?", width:600, button_yes: "Replace", button_cancel: "Abort")
    if @comboFiles == "Current Document"
      total = replace_all(@tabs.docs[@tabs.page])
    elsif @comboFiles == "All Open Documents"
      total = replace_all_open()
    elsif @comboFiles == "All Files in Project"
      total = replace_all_closed()
    end
    alert("Total Replacements:  #{total.to_s}", headline: "Files Updated")
  end

  def replace_all(page)
    page.buffer.place_cursor(page.buffer.start_iter)
    move(page, :forward)
    return page.context.replace_all(@builder[:entryReplace].text, @builder[:entryReplace].text.length)    
  end

  def replace_all_open()
    total = 0
    (0..@tabs.n_pages-1).each do |i| 
      total = total + replace_all(@tabs.docs[i])
    end
    return total
  end

  def replace_all_closed()
    total = 0
    mod = @checkCase ? "" : "i"
    Find.find(Dir.pwd) do |path|
      Find.prune if path =~ /\/glade$/ or path =~ /\/docs$/ 
      if (File.extname(path) == ".rb" or File.extname(path) == ".erb") and not File.directory?(path) 
        next if not @tabs.docs.all? { |doc| doc.full_path_file != path }  # skip open docs
        txt = File.open(path, "r").read
        count = @checkCase ? txt.scan(/#{@entryFind}/).length : txt.scan(/#{@entryFind}/i).length
        if count > 0
          total = total + count
        end
        if @checkCase
          txt.gsub!(/#{@entryFind}/, @entryReplace)
        else
          txt.gsub!(/#{@entryFind}/i, @entryReplace)
        end
        File.open(path, "w") { |f| f.puts(txt) }
      end
    end
    return total
  end


  def comboFiles__changed(*a)
    if @builder[:comboFiles].active_text == "All Files in Project"
      @builder[:buttonNext].label = "Scan Disk"
      @builder[:buttonPrevious].visible = false
    else
      @builder[:buttonNext].label = "Next"
      @builder[:buttonPrevious].visible = true
    end
  end

end

