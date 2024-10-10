
class BalanceClass

  def initialize(value)
    @value = value  # Float
  end

  
  def each_cell(col, ren, model, iter)
      ren.text = @value.to_s
      ren.foreground = @value < 0 ? "darkred" : "black"
      ren.weight = @value < 0 ? 700 : 400  # bold

      #set background based on customer column
      name_col = iter[ren.view.id(:name)]
      if name_col
        ren.background = name_col.state != "CA" ? "papayawhip" : "white"
      end
  end

end
