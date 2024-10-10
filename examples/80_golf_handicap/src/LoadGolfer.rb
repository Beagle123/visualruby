  def load_new_golfer
    files = []
    names = []
    Dir[File.expand_path("*.yaml")].each do |file_name|
      files << file_name
      names << File.basename(file_name, ".*")
    end
    
    answer = files.empty? ? false : alert("Choose Golfer:", data: names, button_no: "New Golfer")
    
    if answer.is_a?(String)
      load_file = files[names.index(answer)]
    elsif answer == false
      golfer_name = alert("Enter Name of Golfer to Create a new Handicap File:",
        input_text: "",
        button_yes: "Add Golfer"
        )
      exit! unless golfer_name.is_a?(String) 
      exit! unless golfer_name.length > 2
      load_file = golfer_name.downcase.tr("^a-z\s", '').gsub(" ", "_") + ".yaml"
    else
      exit!
    end
    
    VR::load_yaml(Handicap, load_file).show_glade
    
  end
