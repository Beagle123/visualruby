
The last example showed how easy it is to create a VR::ListView but it needed
to look a little better.

In this example, we will fix these items:

1) The columns are squished together on the left side.
2) The width is too wide
3) The "Balance" numbers and header needs to right-justify, so it forms a column.
4) The "Balance" numbers should have 2 decimal places.
5) Negatave balances shold be in red.

First, we fix the attributes of the columns, and later we'll fix the individual cells.
To change attributes for whole columns,  the col_attr() and col_[attribute_name] methods 
are used:

  col_width(name: 160, balance: 120)
  col_attr(:balance, alignment: 1, xalign: 1)  

This will solve issues 1, 2 and 3.  This is a simple example, but the col_attr() method 
can do much more:

  col_attr(width: 200)  # changes width of ALL columns to 200
  col_attr(:balance, :name, background: "pink", foreground: "gray")

It can handle any number of columns and attributes.  Also, it works on the column and
renderer's attributes so you can change renderer's attributes too.  Likewise the 
col_[attribute_name] method is useful to change one attribute for many columns:

  col_width(200)  # changes all widths to 200 (same as above)
  col_foreground( "gray", :balance, :name)

The col_[attribute_name] method works for any attribute.  So, col_xalign() and col_background() both work. 
These methods are very similar: they both just set attributes for columns and renderers.
But the col_attr sets multiple attributes for columns, whereas the col_[attribute_name] 
sets a single attribute for multiple columns.  You can use either one.  You can't go wrong.

Individual Cells

To make the negative balances appear in red, and truncate the numbers to 2 decimal places,
we need to operate on each individual cell.  Gtk::TreeView has a method called,
set_cell_data_func() that accepts a code block to be executed on each cell, and the result
gets painted on the screen.  This is a complicated method to use.  VR::ListView added a 
shortcut method named each_cell_method() that just passes a method to Gtk's set_cell_data_func()
but is much easier to use:

  def initialize()
    ...
    each_cell_method(:balance, method(:make_negatives_red))
  end    

  def make_negatives_red(col, rend, model, iter)
      col_id = id(rend.model_sym)
      balance = iter[col_id]
      if balance < 0
          rend.text = "(%.2f)" % balance.abs
          rend.foreground = "darkred" 
          rend.weight = 700
      else
          rend.text = "%.2f" % balance 
          rend.foreground = "black"
          rend.weight = 400 
      end
  end

The each_cell_method() line is telling it to call the make_negatives_red() method on each cell
in the :balance column.  The result will be displayed on the screen.

The make_negatives_red method must accept four parameters, (col, rend, model, iter) because
the Gtk::TreeView will be passing it those 4 parameters.  This is Gtk's business.  It will
always pass those parameters, so you must write your method to accept them.

There's a wrinkle to this story:  Because this is a VR::ListView (not Gtk), the make_negatives_red() method
will be passed a VR::TreeViewColumn, VR::CellRendererText and a VR::Iter instead of their Gtk
equivalents.

That allows us to do this:

  col_id = id(rend.model_sym)
  balance = iter[col_id]

So using VR::ListView, you can look up the symbol of the column.  Then use the id() method to
retreive the column number used by Gtk.  This illustrates the benefits of VR::ListView.

Also, because the make_negatives_red() function looks up the column number for itself, it can
be reused on any column:

  each_cell_method( :degree_angle,  method(:make_negatives_red))
  each_cell_method( :weight_diff,   method(:make_negatives_red))
  each_cell_method( :spin_rate,     method(:make_negatives_red))

This would work on all those number columns.
 

There is a list of color names here:

https://drafts.csswg.org/css-color/#named-colors 
 






    
