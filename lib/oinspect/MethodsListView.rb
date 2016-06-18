module VR::ObjectInspector

  class MethodsListView < VR::ListView

    def initialize(obj)
      super(:method => String, :arity => String, :parameters => String)
      obj.methods.each do |meth|
        row = add_row
        row[:method] = meth.to_s
        row[:arity] = obj.method(meth).arity.to_s
        row[:parameters] = obj.method(meth).parameters.to_s
      end
    end

  end

end
