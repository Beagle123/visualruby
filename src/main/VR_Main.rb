

class VR_Main 

  include GladeGUI

  attr_accessor :proj_path, :tabs, :shell, :builder, :file_tree  
  
  def initialize(argv)
    # can pass project on command line
    @proj_path = VR_Tools.vr_project?(argv[0]) ? argv[0] : nil
  end 


  def before_show

    # there must be a visualruby directory:
    required_project = File.join(ENV["HOME"],"","visualruby", "examples", "alert_box")
    menuInstallExamples__activate if not VR_Tools.vr_project?(required_project)

    # load global settings (requires /home/visuaruby folder exists
    $VR_ENV_GLOBAL = VR::load_yaml(VR_ENV_GLOBAL, VR_ENV_GLOBAL::GLOBAL_SETTINGS_FILE)
    if !File.exist?($VR_ENV_GLOBAL.default_project) or !File.directory?($VR_ENV_GLOBAL.projects_home) #start over
      File.delete(VR_ENV_GLOBAL::GLOBAL_SETTINGS_FILE)
      $VR_ENV_GLOBAL = VR::load_yaml(VR_ENV_GLOBAL, VR_ENV_GLOBAL::GLOBAL_SETTINGS_FILE)
    end    



    @proj_path ||= $VR_ENV_GLOBAL.default_project


    @file_tree = VR_File_Tree.new(self, File.expand_path(File.dirname(__FILE__) + "/../../img"))
    @builder["scrolledwindowFileTree"].add_child(@file_tree) 

    #add document notebook    
    @tabs = VR_Tabs.new(self) 
    @builder["boxTabs"].add(@tabs)
    @tabs.show

    #add shell textview
    @shell = VR_TextShell.new(@tabs)
    @builder["scrollShell"].add_child(@shell)
    @shell.show

    #add local gem tab
    @gem_tree = VR_Local_Gem_Tree.new(self)
    @builder['scrolledLocalGems'].add_child(@gem_tree)
    @gem_tree.show
 
    #add remote gem tab
    @remote_gem_tree = VR_Remote_Gem_Tree.new(self)
    @builder["scrolledRemoteGems"].add_child(@remote_gem_tree)
    @remote_gem_tree.show

    load_project

  end

  def load_project() # assumes valid_project? is true
    FileUtils.cd(@proj_path)
    @builder['window1'].title = "VR: " + File.basename(Dir.pwd)
    @builder["labelStatus"].label = Dir.pwd
    @file_tree.root = @proj_path
    @file_tree.refresh()
    @shell.buffer.text = "" 
    $VR_ENV_GLOBAL.default_project = @proj_path
    VR::save_yaml($VR_ENV_GLOBAL)  
    load_state()
  end

  def toolOpenFolder__clicked(*a)
    save_state
    return unless @tabs.try_to_save_all(:ask=>true)
    old_path = @proj_path
    OpenProject.new(self).show_glade(self)
    if old_path != @proj_path
      @tabs.try_to_save_all(:ask => false, :close => true)
      load_project()
    end  
  end

  def notebookTree__switch_page(notebook, scroll, new_page, *args) # notebook.page = page leaving
    case new_page 
      when 1 then @gem_tree.refresh() 
      when 2 then @remote_gem_tree.refresh(false) #false = don't force refresh
    end
  end 

  def menuCloseAll__activate(*a)
    @tabs.try_to_save_all(:close=>true) 
  end

  def menuSettings__activate(*a)
    $VR_ENV.show_glade(self)
  end

  def menuGlobalSettings__activate(*a)
    $VR_ENV_GLOBAL.show_glade(self)
    @tabs.update_style_all()
  end

  def menuWWWRubygems__activate(*a)
    VR_Tools.popen("#{$VR_ENV_GLOBAL.browser} https://rubygems.org/users/new")
  end

  def menuSaveAll__activate(*a)
    @tabs.try_to_save_all(:ask=>false) # don't prompt 
  end

  def menuNew__activate(*a)
    @tabs.load_tab()
  end

  def menuSaveAs__activate(*a)
    @tabs.save_as()
  end

  def toolRefresh__clicked(*a)
    case @builder['notebookTree'].page
      when 0 then @file_tree.refresh()
      when 1 then @gem_tree.refresh()
      when 2 then @remote_gem_tree.refresh()
    end
  end

  def toolMyYard__clicked(*a)
    begin
      require "my_yard"
    rescue LoadError
      alert "You must install the my_yard gem to generate documents.  \nEnter this command at the command prompt:\n\n<b>gem install my_yard</b>",
        parent: self
      return
    end
    proj = VR::load_yaml(MyYard, File.join(Dir.pwd, ".yardoc", "my_yard.yaml"))
    proj.show_glade()
  end

  def toolViewRDoc__clicked(*a)
    Open3.popen3("#{$VR_ENV_GLOBAL.browser} #{Dir.pwd}/docs/index.html")   
  end

  def toolSave__clicked(*a)  # saves open tab 
    @tabs.try_to_save(false) # false = don't ask
  end  

  def menuNewWindow__activate(*a)
    fn = File.dirname(__FILE__) + "/../../skeleton/document/NewWindow.rb"
    @tabs.load_tab()
    @tabs.set_contents(File.open(fn).read)    
  end

  def menuNewProject__activate(*a)
    save_state
    return unless @tabs.try_to_save_all(:ask=>true)
    old_path = @proj_path
    NewProjectGUI.new(self).show_glade(self)
    if old_path != @proj_path
      @tabs.try_to_save_all(:ask=>false, :close=>true)
      load_project
    end  
  end

  def toolBackUp__clicked(*a)
    return unless @tabs.try_to_save_all(:ask=>true)
    VR_Tools.back_up()
  end

  def toolIndent__clicked(*a)
    @tabs.docs[@tabs.page].insert_before_selected(" " * $VR_ENV_GLOBAL.tab_spaces.to_i )
  end

  def toolUnIndent__clicked(*a)
    @tabs.docs[@tabs.page].delete_before_selected(" " * $VR_ENV_GLOBAL.tab_spaces.to_i)
  end

  def toolComment__clicked(*a)
    @tabs.docs[@tabs.page].insert_before_selected("# ")
  end

  def toolUnComment__clicked(*a)
    @tabs.docs[@tabs.page].delete_before_selected("# ")
  end

  def toolRun__clicked(*a)
     run_command($VR_ENV.run_command_line)
  end     

  def toolHome__clicked(*a) 
    return unless VR_Tools.vr_project?($VR_ENV_GLOBAL.home_project)
    return if $VR_ENV_GLOBAL.home_project == @proj_path
    return unless @tabs.try_to_save_all(:ask=>true)
    @tabs.try_to_save_all(:ask => false, :close => true)
    @proj_path = $VR_ENV_GLOBAL.home_project
    load_project()
  end

  def run_command(cmd)
    save_state()
    return unless @tabs.try_to_save_all(:ask => false) # false = don't prompt for changes to files
    cur_dir = Dir.pwd
    result = "\n#{cur_dir}$ #{cmd}\n"
    result += `#{cmd} 2>&1`
    FileUtils.cd(cur_dir)
    @shell.hilight_links(result, true)
  end

  def save_state
    return unless $VR_ENV
    $VR_ENV.width, $VR_ENV.height = @builder["window1"].size()
    $VR_ENV.panel_pos = @builder["panelMain"].position
    $VR_ENV.notebook_panel_position = @builder["panelNotebook"].position
    $VR_ENV.open_folders = @file_tree.get_open_folders()
    $VR_ENV.open_files = @tabs.get_open_fn()
    $VR_ENV.current_file = @tabs.docs[@tabs.page].full_path_file
    $VR_ENV.current_line = @tabs.docs[@tabs.page].line_at_cursor()
    VR::save_yaml($VR_ENV)
  end

  def load_state
    $VR_ENV = VR::load_yaml(VR_ENV, VR_ENV::SETTINGS_FILE)
    @builder["window1"].resize($VR_ENV.width, $VR_ENV.height)
    @builder['panelMain'].set_position($VR_ENV.panel_pos)
    @builder["panelNotebook"].set_position($VR_ENV.notebook_panel_position)
    @tabs.open_file_names($VR_ENV.open_files)
    @file_tree.open_folders($VR_ENV.open_folders)
    @tabs.load_tab($VR_ENV.current_file)
    @tabs.docs[@tabs.page].jump_to_line($VR_ENV.current_line)
  end

  def menuCreateGemspec__activate(*a)
    if file_name = VR_Tools.create_gemspec()
      @tabs.destroy_file_tab(file_name)
      @tabs.load_tab(file_name)
      @file_tree.refresh()
    end
  end

  def buttonNext_clicked
    @shell.jump_to()
  end

  def buttonFind_clicked
    str = @builder["entryFind"].text
    str = str.length < 2 ? @tabs.docs[@tabs.page].selected_text() : str
    return if str.nil? or str.length < 2
    text = (@builder["radioOnDisk"].active?) ? @tabs.find_in_all(str) : @tabs.find_in_tabs(str)    
    @shell.hilight_links(text, false)
  end  

  def buttonReplace_clicked
    @tabs.docs[@tabs.page].replace(@builder[:entryReplace].text)
  end

  def entryFind__key_press_event(me, evt)
    return if evt.keyval != 65293 #enter key
    buttonFind_clicked
  end

  def menuTutorials__activate(*a)
    VR_Tools.popen("#{$VR_ENV_GLOBAL.browser} https://beagle123.github.io/visualruby")
  end
  
  def menuInstallExamples__activate(*a)
    path = File.join(ENV["HOME"], "visualruby", "examples")
    VR.copy_recursively(File.expand_path(File.join(File.dirname(__FILE__),"..","..","examples")), path) 
    alert("Installing example projects in:\n\n<b>#{path}</b>\n\n" +
          "The best way to learn about visualruby is to follow the examples. " +
          "Each one is a lesson on how to use visualruby.\n\n" +  
          "Click on the <b>Open Project</b> button, and open the first project.  " +
          "Then read the <b>README</b> file. ",
      :parent => self,  
      :headline => "Installing Example Projects...",
      :width => 620) 
    @proj_path = File.join(ENV["HOME"], "visualruby", "examples", "01_phantom") 
  end

  def menuAbout__activate(*a)
    alert("version " + VERSION, headline: "visualruby", parent: self) 
  end

  # needed so tabs can be saved, called before destroy, must return false to close wndow.
  def window1__delete_event(*args)
    ret = !@tabs.try_to_save_all(:ask=>true)
    save_state
    return ret
  end

  def menuQuit__activate(*a)   
    @builder[:window1].destroy
  end

  def tabs__switch_page(_self, x, page_num)
    return unless tab = @tabs.docs[page_num] # needed. sometimes nil
    @builder[:labelStatus].label = "Project:  #{@proj_path}    File:  #{tab.full_path_file}     visualruby v#{VERSION} "
    tab.modified_time_matches()
  end

end
   
