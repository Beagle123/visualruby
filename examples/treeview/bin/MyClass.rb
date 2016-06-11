
class MyClass #(change name)

  include GladeGUI

  def before_show()
    @tree = VR::TreeView.new(:name => String, :age => Integer)
    top = @tree.add_row(nil)
    top[:name] = "Family"
    eric = @tree.add_row(top, :name => "Eric", :age => 47)
    joe = @tree.add_row(eric, :name => "Joe", :age => 15)
    ann = @tree.add_row(eric, :name => "Ann", :age => 17)
    pat = @tree.add_row(ann, :name => "Pat", :age => 2)
    steve = @tree.add_row(top, :name => "Steve", :age => 51)
    
    #alternate format
    harvey = @tree.add_row(top)
    harvey[:name] = "Harvey"
    harvey[:age] = 60
    @scrolledwindow1 = @tree #adds tree to the scrolledwindow
  end  

end

