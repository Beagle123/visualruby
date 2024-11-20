

class CustomerClass

  attr_accessor :state

  def initialize(name, address, state)
    @name = name
    @address = address
    @state = state
  end

  def each_cell(col, ren, model, iter)
    ren.text = @name # necessary, this appears in the table
    ren.background = @state != "CA" ? "papayawhip" : "white"
  end

end
