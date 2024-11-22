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

### Then just click the "Run" button:

![Hello](https://beagle123.github.io/visualruby/img/hello.png)

Obviously, this is a trivial example, but there are about 20 example
programs that illustrate many of the things you can do.  The best way
to learn it, is to follow these example programs. (in ~/visualruby/examples).
They are "bite size" programs that show one idea at a time.

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


## Windows

First, download the "Windows Ruby Installer" and run it.  Make sure you install
the additional software so Gtk+ can be installed in that environment.

Then open the "Ruby Command Prompt" and run:

```
gem install visualruby
```
 Then run the command to start visualruby:

```
vr
```



