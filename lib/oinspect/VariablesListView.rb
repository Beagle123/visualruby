module VR::ObjectInspector

  class VariablesListView < VR::ListView

    def initialize(obj)
      super(variable: String, type: String, class: String, value: String, obj: Object)
      obj.instance_variables.each do |var|
        row = add_row
        row[:variable] = var.to_s
        row[:class] = obj.instance_variable_get(var).class.name
        row[:value] = obj.instance_variable_get(var).to_s
        row[:type] = "var"
        row[:obj] = obj.instance_variable_get(var)
      end
      if obj.is_a?(Hash)
        obj.each do |key, val|
        row = add_row
        row[:variable] = key.to_s
        row[:class] = val.class.name
        row[:value] = val.to_s
        row[:type] = "key"
        row[:obj] = val
        end
      end
      if obj.is_a?(Array)
        obj.each_index do |i|
        row = add_row
        row[:variable] = i.to_s
        row[:class] = obj[i].class.name
        row[:value] = obj[i].to_s
        row[:type] = "index"
        row[:obj] = obj[i]
        end
      end
    end

  end

end
