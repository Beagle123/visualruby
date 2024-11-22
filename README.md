# Visual Ruby GUI Builder

Visualruby was designed specifically for rubyists who want to add
a GUI to their ruby scripts.  It enormously simplifies the process
of adding GTK+ windows to your applications.  Visualruby is completely
integrated with the glade interface designer, so you only need to
click on a ruby file to edit its widgets using glade.

You can create a .gemspec file, compile your
gem, install your gem, or push, yank or uninstall your gem with
just one mouse-click.

![Main Screen](https://beagle123.github.io/visualruby/img/main.png)


## Install Instructions

# Linux, Ubuntu

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



