Press the "Run" button and see what happens.

This example shows the best way to insert a Gtk::TreeView object into your forms.
If you double click on the FamilyTree.glade file, you will see that there is no Gtk::TreeView
in the form.  Instead, there is an empty Gtk::ScrolledWindow named "scrolledwindow1."

This scrolledwindow1 is a blank canvas where we can insert our TreeView.

Glade had a Gtk::TreeView widget that you can insert in glade, but it is very problematic
to work with because it is stuck in a glade form.  A much better approach is to create
a custom Gtk::TreeView and insert it into the form like this:

  @builder["scrolledwindow1"].add_child(@my_tree)  

This example uses VR_TreeView from the vrlib library.  It is a subclass of Gtk::TreeView but adds
a lot of functionality and ease of use.

Its beyond our scope to describe all the complexities of Gtk::TreeView here, but a major
advantage to using VR::TreeView is that you can use symbols for the field names:

  @tree = VR::TreeView.new(name: String, age: Integer) 

Then identifly the fields by :name and :age instead of a column number as Gtk::TreeView uses.

There will be more on TreeViews and ListViews in the following examples.
