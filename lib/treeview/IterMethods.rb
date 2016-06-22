
module VR::ViewCommon

#  The IterMethods module extends the GtkTreeIter class so it can work with
#  visualruby's colum ID symbols as well as Gtk's column numbers. 
#  

  module IterMethods

      attr_accessor :column_keys
      @column_keys = nil

  #  The [] method returns the value from the specified column in the iter:
  #  
  #   val = iter[:name]
  #  
  #  - col_id -- Either a visualruby column ID symbol, as above, or an integer.
  #  
    
      def [](col_id)
        if col_id.is_a? Fixnum
          super
        else
          get_value(id(col_id))
        end
      end

      def []=(col_id,val)
        if col_id.is_a? Fixnum
          super(col_id, val)
        else
          super(id(col_id), val)
        end
      end

  #  The id() method translates visualruby's colum ID symbols into integers that
  #  GtkTreeIter can use:
  #  
  #   iter = model.append
  #   iter[id(:name)] = "Henry"
  #  
  #  Normally, its best to use VR's "rows" instead.  They will already use the column ID symbols.
  #  
      def id(col_id) # :nodoc:
        return (col_id.is_a? Fixnum) ? col_id : @column_keys.index(col_id)
      end

  #  This will load the values of any object into the iter.  It will look at all the
  #  instance variables, methods, and ActiveRecord fields and match them to
  #  columns in a VR::ListView or VR::TreeView.  For example, if your object
  #  has an instance variable, @name, this will fill in a column with the symbol :name.
  #  
  #   class MyClass
  #     @name = "Henry"
  #   end
  #  
  #   @view = VR::ListView.new(:name => String)
  #   my = MyClass.new
  #   row = @view.add_row()
  #   row.load_object(my)  # assigns "Henry" to first cell
  #  
  #  
  #  -obj--any ruby object or object subclassed from ActiveRecord::Base.
  #  
      def load_object(obj)
        class_sym = obj.class.name.to_sym
        self[class_sym] = obj if @column_keys.include?(class_sym)
        @column_keys.each do |k|
          begin
          self[k] = obj.send(k) if obj.respond_to?(k.to_s)
          rescue
          end
        end
        keys = @column_keys.inject([]) { |ar, e| ar << e.to_s }
        matches = obj.attributes.keys & keys if obj.attributes.is_a? Hash
        matches.each do |field| 
          begin
          self[field.to_sym] = obj.attributes[field] 
          rescue
          end
        end 
        obj.instance_variables.each do |name|
          self[name] = instance_variable_get(name) if @column_keys.include?(name) 
        end
      end
    
  end

end
