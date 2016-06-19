#  This is a listview that contains objects!  THe columns contain a date object, a user defined, and
#  a long (blob) text string.  The columns are named :join, :name, and :quote.

class ListViewObjects < VR::ListView

  def initialize()

    #define column types, then call super()
    @cols = {}
    @cols[:join] = VR::Col::CalendarCol  
    @cols[:name] = DataObject
    @cols[:quote] = VR::Col::BlobCol
    super(@cols)
    col_title(:join => "Joined On", :name => "Name (email)", :quote => "Favorite Quote")
    col_width(:join => 200, :name => 300)    
    populate_data()
  end



  def populate_data()  # just populates model with random data
    row = add_row() 
    row[:join] = VR::Col::CalendarCol.new DateTime.new(2011, 1, 15, 7, 23, 0) 
    row[:name] = DataObject.new("Henry Johnson", "18458 S Beauford St.", "hohohoja@email.net", "154-453-8585")
    row[:quote] = VR::Col::BlobCol.new "I have come to believe that the whole world is an enigma, a harmless enigma that is made terrible by our own mad attempt to interpret it as though it had an underlying truth.\n\n- Umberto Eco"
    row = add_row()
    row[:join] = VR::Col::CalendarCol.new DateTime.new(1997, 7, 24, 3, 26, 0)
    row[:name] = DataObject.new("Theo Alexander", "935 Medford Ln.", "noreply@gmail.com", "586-673-9474")
    row[:quote] = VR::Col::BlobCol.new "The instinct of nearly all societies is to lock up anybody who is truly free. First, society begins by trying to beat you up. If this fails, they try to poison you. If this fails too, they finish by loading honors on your head.\n\n- Jean Cocteau (1889-1963)"
    row = add_row()
    row[:join] = VR::Col::CalendarCol.new DateTime.new(1987, 5, 11, 6, 43, 0)
    row[:name] = DataObject.new("Billy Vincent", "675 Telegraph Rd.", "jimmy@visualruby.net", "432-485-5863")
    row[:quote] = VR::Col::BlobCol.new "There are two ways of constructing a software design; one way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies. The first method is far more difficult.\n\n- C. A. R. Hoare"
  end


end
