
class Find_Replace

  include GladeGUI

  def initialize(tabs)
    @tabs = tabs
    @page = @tabs.docs[@tabs.page]
    @entryFind = @tabs.docs[@tabs.page].selected_text()
  end

  def buttonNext__clicked(*a)
    @page.settings.set_case_sensitive(@builder[:checkCase].active?) 
    @page.settings.set_search_text(@builder[:entryFind].text)
# alert @page.buffer.cursor_position
    cursor_iter = @page.buffer.get_iter_at(:offset => @page.buffer.cursor_position + 1)

    @found, @start_iter,@end_iter, @wrapped = @page.context.forward(cursor_iter)
    if @found
      @page.hilight_selection(@start_iter, @end_iter) 
    elsif @builder[:comboFiles].active_text == "All Open Documents"
      new_page = @tabs.page == @tabs.docs.length-1 ?  0 : @tabs.page + 1 
      @tabs.page = new_page
      @page = @tabs.docs[@tabs.page]
      @page.buffer.place_cursor(@page.buffer.get_iter_at(:offset => 0))
      buttonNext__clicked()
    else
alert "wiffed"
    end
  end

  def buttonReplace__clicked(*a)
    s, e = @page.buffer.selection_bounds
    @page.context.replace(s, e, @builder[:entryReplace].text, @builder[:entryReplace].text.length)
  end

  def buttonPrevious__clicked(*a)
    result = @tabs.docs[@tabs.page].find_previous(@builder[:entryFind].text)
  end

  def buttonReplaceAll__clicked(*a)
    @context.replace_all(@builder[:entryReplace].text, @builder[:entryReplace].text.length)
  end

end

