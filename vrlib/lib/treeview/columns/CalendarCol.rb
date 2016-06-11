
module VR

#  The CalendarCol class is a simple calendar window where you can edit
#  the date:
#  
#  http://visualruby.net/img/calendar.jpg
#  
#  This class is very useful when you want to display and edit dates
#  in a VR::ListView.  You can define a column with the type VR::CalendarCol
#  and the column will display as a date, and when the user clicks on the
#  date, a calendar window will appear so he/she can edit it:
#  
#   @view = VR::ListView.new(:name => String, :birthday => VR::CalendarCol)
#   row = @view.add_row
#   row[:name] = "Eric"
#   row[:birthday] = VR::CalendarCol.new(DateTime.new(1966, 7, 14))
#  
#  See the example project, "listview_objects" for more.

  class CalendarCol 

    include GladeGUI

    attr_accessor :date, :date_format, :show_time, :show_calendar
#  
#  - datetime - Instance of DateTime class that holds the date value.
#  - date_format - String that holds the Ruby date format. Default: "%d %b %Y   %I:%M%p"
#  - show_time - true/false If this is false, the time will not appear in the edit window.
#  - show_calendar - true/false If this is false, Calendar will not appear.  Only time will edit.
#  
    def initialize(datetime, flags = {})  #flags = :hide_date => true, hide_time => true, :format => "%d %b %Y   %I:%M%p"
      @format = flags[:format]
      @format ||= flags[:hide_date] ? "%I:%M%p" : "%d %b %Y   %I:%M%p"
      @format ||= flags[:hide_time] ? "%d %b %Y" : @date_format
      @hide_date = flags[:hide_date]
      @hide_time = flags[:hide_time]
      @show_calendar = show_calendar
      @date = datetime
      @hour = @date.strftime("%I").to_f
      @minute = @date.min()
      @am = (@date.hour < 12)
      @pm = !@am
    end

    def show_glade(parent = nil)
      super      
      @builder["hboxTime"].hide if @hide_time
      @builder["date"].hide if @hide_date
    end

# displays time according to the @date_format instance variable.  If you want to
# change the appearance of this object, assign a new vale to @date_format.
  
    def to_s
      @date.strftime(@format)
    end

    def am__toggled(*args) # :nodoc:
      @builder["pm"].active = !@builder["am"].active?
    end

    def pm__toggled(*args) # :nodoc:
      @builder["am"].active = !@builder["pm"].active? 
    end

    def buttonSave__clicked(*args) # :nodoc:
      get_glade_variables()
      m = @builder["am"].active? ? "AM" : "PM"
      t = DateTime.strptime("#{@hour.to_i.to_s} #{@minute.to_i.to_s} #{m}", "%I %M %p")
      @date = DateTime.new(@date.year, @date.month, @date.day, t.hour, t.min, 0)
      @builder["window1"].destroy
    end

    def buttonCancel__clicked(*args) # :nodoc:
      @builder["window1"].destroy      
    end

    def <=>(calendar)
      return @date <=> calendar.date
    end

    def value
      @date
    end

  end

end
