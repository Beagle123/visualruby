
CREATING A STANDALONE EXE

This project will create a standalone executable file using rubygems.
The program will run independently from visualruby, but it depends
on vrlib.rb, so it depends on the visualruby gem.

Here are the steps needed to create the executable file, my_program:

1) Right-click on the script, my_program and make it the main program (bold).

2) Create a my_program.gemspec file by going to:
  
  Tools > Create Gemspec File

This will add a .gemspec file to the project.  It will set the executable file
to be the main program, my_program.  You can click on it to look at it.

3) Right click on the my_program.gemspec file and Build the gem.  It will appear
  in the project

4) Right-click on the my_project-0.0.1.gem file and select:

  Install Gem

This will install it locally on your computer.  

Now you're ready to go.  You can go to the command prompt, and run:

  my_program

When you do this process, visualruby is just executing the gem commands.  So
if you experience and difficulty, just run the commands manually to see what's
going on:

  gem install my_program-0.0.1.gem --local

etc.  




 
