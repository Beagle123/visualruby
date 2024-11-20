
While Gtk offers a Gtk::TreeView and Gtk::ListView class, they are
very difficult to use.  Visualruby has created subclasses of Gtk::TreeView
and Gtk::ListView that are much easier to use.  The TreeView and ListView classes are
almost the same class so all the methods and properties here can be applied to
both ListViews and TreeViews.  This example is for a VR::ListView, but everything applies to 
VR::TreeView too.

The VR::ListView constructor has the benefit of applying names to all the columns:

  @view = VR::ListView( name: String, age: Integer )

The VR::ListView class will keep a hash of column names that can be retreived 
using the id() method:

  @age = id(:age)  #  ==> 1

This is much easier than Gtk's classes which use numbers to identify columns.

Since VR::ListView is a subclass of Gtk::ListView, you can still use all the properties
from Gtk::ListView including the ".model" property that holds all the data.
The ".model" property is like a complete table (or spreadsheet) of data with columns and rows.
When you access the ".model", you need to use the id() method so you pass a column number:

  row = model.first  # this is model from Gtk::ListView
  x = row[id(:age)]  # ==> that row's age

In this example, it calls the Gtk::ListView's #append method to add rows:

  row = model.append
  row[id(:name)] = "Helen"  # same as row[0] = "Helen"
  etc.

Again, the id() method is converting the column symbol, ":name" to the correct integer
for the column, so you can identify columns by their symbol.

Summary:
1) using VR::ListView and VR::Treeveiw allows naming of columns
2) You can still use Gtk::Listview's methods and properties because it's their superclass

This example creates the most basic VR::ListView, but it can do a lot more including
changing columns' and cells' appearance, changing the header, sorting etc.
Click "Open Project" to go to the next example...




There is a list of color names here:

https://drafts.csswg.org/css-color/#named-colors




    








    
