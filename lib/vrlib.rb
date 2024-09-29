require "gtk3"
require "date"
require "yaml"
require "find"
require "fileutils"


#tools go first
require_relative "GladeGUI"
require_relative "VR_GtkWindow"
require_relative "Alert"
require_relative "DragDrop"
require_relative "SavableClass"
require_relative "Tools"

require_relative "treeview/columns/BlobCol"
require_relative "treeview/columns/CalendarCol"
require_relative "treeview/columns/CellRendererCombo"
require_relative "treeview/columns/CellRendererObject"
require_relative "treeview/columns/CellRendererProgress"
require_relative "treeview/columns/CellRendererSpin"
require_relative "treeview/columns/CellRendererText"
require_relative "treeview/columns/CellRendererToggle"
require_relative "treeview/columns/ComboCol"
require_relative "treeview/columns/CurrencyCol"
require_relative "treeview/columns/ImageCol"
require_relative "treeview/columns/ProgressCol"
require_relative "treeview/columns/SpinCol"
require_relative "treeview/columns/TreeViewColumn"

require_relative "treeview/ViewCommon"
require_relative "treeview/IterMethods" 
require_relative "treeview/TreeView"
require_relative "treeview/FileTreeView"
require_relative "treeview/ListView"

#then stuff that relies on tools
require_relative "oinspect/MethodsListView"
require_relative "oinspect/ObjectInspectorGUI"
require_relative "oinspect/VariablesListView"



