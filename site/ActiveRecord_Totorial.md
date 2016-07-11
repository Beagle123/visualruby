# @title Active Record Tutorial

# ActiveRecord Tutorial

Note:  Visualruby has been updated since these videos were made, so the syntax is slightly
different.   For example, there is no need to write your own **show()** method.
See the example projects in the **/examples** folder for updated examples.  The text below
is updated, the videos are not.

<p>
  <iframe width="480" height="360" src="https://www.youtube.com/embed/uySVKltD7fk" frameborder="0" allowfullscreen>
  </iframe>
</p>

Any ActiveRecord object can have a GUI interface added to it easily using visualruby.
Using Ruby and ActiveRecord you can easily add, delete, and save records to a
database. However, its considerably more difficult to edit records because there
is no way to display the records on the screen.  Visualruby solves that problem.

ActiveRecord objects can use the GladeGUI interface to add a GUI, just like any other class.
You simply add this line to your class:

```ruby
  include GladeGUI
```

To illustrate adding a GUI, I'll present a simple example of an existing ActiveRecord 
class named "Person:"

```ruby
  class Person < ActiveRecord::Base

  end
```

This class will automatically access a table named <b>people</b> in the database.  Also,
ActiveRecord will scan the table to learn the names of the fields in the **people**
table.  So, there are several fields in this table even though they're not listed in the class.

The **people** table consists of these fields:

```ruby
    name
    address
    phone
    email
```
To add a GUI to the **Person** class, you need to add these lines of code:

```ruby
 class Person < ActiveRecord::Base

   include GladeGUI

 end
```
  
Now the Person class is ready to be shown on the screen as a GUI.  However, we still need to 
create a glade form to show the fields.  In the visualruby IDE, you need to right-click
on the **Person.rb** file to create a form using glade.  You can see this done
in the above video.  When you create a glade form form for the **Person** class, it will automatically
create a file named **Person.glade** in the "glade" directory, so when you run the **show_glade()** method it
will find the glade form that corresponds to the **Person** class and show it on the screen.

Then you need to add 4 entry boxes with the names, **name, address, phone, email** 
to correspond to the names of the fields in the table.  See the examples to see how this is done.

When the glade file is finished, the **show_glade()** method will load the
glade form into memory, and automatically fill
all the form's fields with their corresponding values (i.e. the entry box named **address** will
be filled with the **address** field etc.)  And the **show_glade()** method will simply show the window on the
screen:

![Person Object](http://visualruby.net/img/person.jpg)

#Editing Records

The above glade form only shows the fields from the **People** table on the screen.  If you
want to edit the records you simply need to add a "Save" button to the form and attach code to it:

```ruby
 class Person < ActiveRecord::Base

   include GladeGUI

   def buttonSave__clicked
     get_glade_all()
     save
   end

 end
```

The above example assumes that you've added a button named "buttonSave" to your glade form.
You don't need to use the GLibInstantiatable#signal_connect method to connect a signal to 
the button.  You only need to name the method according to visual ruby's naming convention:  
(method name = **buttonSave__clicked**.  See Signals tutorial for more).

The **get_glade_all()** method will update the values for the ActiveRecord fields from the glade form.
For example, if you edited the person's email address on the screen, the get_glade_all() method
would update the value of the **Person.email** in ActiveRecord to the same value as the screen shows.  The **get_glade_all()**
method is simply the opposite of the **set_glade_all()** method.  So the **get_glade_all()** method
updates the instance of **Person**, but not the physical database on the server.  The save() 
method is from the superclass, ActiveRecord::Base, and it simply commits the cahnges to the actual
database server.

You can also easily add a delete button that calls ActiveRecordBase#delete.

<p>
  <iframe width="480" height="360" src="https://www.youtube.com/embed/3f1Lj5Q2Q8g" frameborder="0" allowfullscreen>
  </iframe>
</p>
  
