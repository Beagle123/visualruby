
This example shows how you can make an array of glade widgets
that corresponds to an array in ruby, and you can use
the get_glade_variables and set_glade_variables to
update between the form and variables.

In the glade form, there are buttons named:

button[0]
button[1]
button[2]
etc.

In ruby there is a  corresponding array with the labels for the buttons.
When show_glade() is run, it automatically runs set_glade_variables(), loading 
the ruby array onto the buttons.  Then the calculator uses the labels to do the
calculations.
