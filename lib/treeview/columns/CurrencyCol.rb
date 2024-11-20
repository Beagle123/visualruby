  
module VR::Col 

  class CurrencyCol
    
    attr_accessor :value, :format
  
    def initialize(value, format = "%.2f")
      set_value(value, format)
    end
  
    def set_value(value, format = "%.2f")
      @value = value
      @format = format
    end
    
    def each_cell(col, ren, model, iter)
      ren.text = to_s()
    end  

    def to_s
      format % @value.to_f
    end
  
  end

end
