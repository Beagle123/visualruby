
SAVING A CLASS TO A YAML FILE

Visualruby has 2 methods that allow you to save any instance of a class to a yaml
file, then retreive it from disk later:

  var = VR::load_yaml(MyClass, "/path/to/file/class_instance.yaml", *args)

and

  VR::save_yaml(var)  # or  VR::save_yaml(self)  from inside class

The first time you use VR::load_yaml(), it will create an instance of MyClass
with a variable, @vr_yaml_file that records the complete file
path used for saving and retreiving it.

When you call VR::load_yaml(), it will try to load the file from disk, but if the file
isn't there, it will create an instance of MyClass that can be saved later.

VR::save_yaml() will write the image of the file to that path.

The "*args" parameter holds all the arguments you wish to pass to the constructor.
So this happens under the hood:

  me = MyClass.new(*args)

To create a savable class, you just need to 





  
