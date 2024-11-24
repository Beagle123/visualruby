# Visual Ruby GUI Builder

Visualruby was designed specifically for rubyists who want to add
a GUI to their ruby scripts.  It enormously simplifies the process
of adding GTK+ windows to your applications.  Visualruby is completely
integrated with the glade interface designer, so you only need to
click on a ruby file to edit its widgets using glade.

You can create a .gemspec file, compile your
gem, install your gem, or push, yank or uninstall your gem with
just one mouse-click.

## Welcome to Easy GUIs

This is the main screen of Visualruby.  It is also and example of
what you can do with visualruby because it was written in Visualruby.
To create a graphical program, you simply create a project directory for your
files, and write your code:

![Main Screen](https://beagle123.github.io/visualruby/img/main.png)

Then just click the "Run" button:

![Hello](https://beagle123.github.io/visualruby/img/hello.png)

Obviously, this is a trivial example, but there are about 20 example
programs that illustrate many of the things you can do.  The best way
to learn visualruby, is to follow these example programs. (in ~/visualruby/examples).
They are "bite-size" programs that show one idea at a time.

To proceed, follow the install instructions, and run the first examples. 

# Install Instructions

## Linux, Ubuntu

Install a ruby version manager like rbenv or RVM. This is necessary because
they will install ruby under your $HOME directory where you have permissions
to install it.  

to test your install of ruby, run this at the prompt:

```
which ruby
```

This should show that your version is under your home directory.  Then Run:

```
gem install visualruby
```
Then run visualruby:

```
vr
```

Next, install the Glade interface designer.  Ubuntu users can find it in the software center
or all Linux users can install it with their package manager:

```
sudo apt install glade
```




## Windows Install

## Install Ruby

First, download the [Windows Ruby Installer](https://rubyinstaller.org).   Choose
a download that includes the DevKit.  Visualruby, Glade and Gtk+ need that DevKit.

The windows system will try to fight you downloading anything that they don't profit from
so you need to select "keep" file.  And run it anyway.  When you click on it, you may
need to select "Show More" then select "keep" before it will let you execute it.

Just install with all defaults that includes MSYS2 which is also necessary.
After, all this completes, you will find a "Command Prompt with Ruby" option
added to the windows menu.  Select it, and open the prompt.

## Install Glade

Now you will need to install the [Glade Interface Designer](https://packages.msys2.org/packages/mingw-w64-x86_64-glade)
This is a MSYS2 package that you can install at the Ruby command prompt:

```
pacman -S mingw-w64-x86_64-glade
```
When this completes, glade will be installed, but it may not work because the windows %PATH% variable
needs to be updated to include the path to the glade.exe file.  To get glade to run, you will need
to add its path in windows settings.  In windows go to:

```
Settings > System > About > Advanced System Settings > Environment Variables > Path > Edit
```
![Edit Env Var](https://beagle123.github.io/visualruby/img/edit_env_var.png)


Here you can add the path to glade.exe, so the command prompt can find it.

![add_to_path](https://beagle123.github.io/visualruby/img/env_glade.png)

Add this path:

```
C:\Ruby33-x64\msys64\mingw64\bin
```

If for some reason, this doesn't match your path, just find the path to glade.exe using
windows commander, and enter the correct path.  But this path should be right.

Once, you've changed the path, you need to save/close everything to have the changes take effect.
So click "ok/save" for all settings, and restart the Ruby command prompt.
When you've sucessfully added the path, it will show on the Ruby command prompt:

![ruby_prompt](https://beagle123.github.io/visualruby/img/ruby_prompt.png)

Success!  Now, at the prompt, you can run:

```
glade
```

## Install VisualRuby Gem

At the "Ruby Command Prompt", run:

```
gem install visualruby
```
 
Then run the command to start visualruby:

```
vr
```

Visualruby will open, and you can double-click on the glade files to use the Glade Designer.


